$csvBatch1 = Import-Csv "C:\Users\Pradnya Rode\OneDrive\Desktop\VS CODE\my shop\New folder\resolved_catalog.csv"

function Fetch-CleanPrice($url) {
    try {
        $req = [System.Net.HttpWebRequest]::Create($url)
        $req.Timeout = 6000
        $req.UserAgent = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36"
        $req.Headers.Add("Accept-Language", "en-IN,en;q=0.9")
        $resp = $req.GetResponse()
        $sr = New-Object System.IO.StreamReader($resp.GetResponseStream())
        $html = $sr.ReadToEnd()
        $sr.Close()
        $resp.Close()

        $price = 0
        if ($html -match 'class="a-price-whole">([0-9,]+)') {
            $price = [int]($matches[1] -replace ",", "")
        } elseif ($html -match '"priceAmount":([0-9\.]+)') {
            $price = [int][double]$matches[1]
        } elseif ($html -match '"price":\s*"?([0-9\.]+)"?') {
            $price = [int][double]$matches[1]
        }

        $orig = 0
        if ($html -match 'class="a-price a-text-price[^"]*"[^>]*>.*?class="a-offscreen">[^0-9]*([0-9,]+)') {
            $orig = [int]($matches[1] -replace ",", "")
        } elseif ($html -match 'M\.R\.P\.:[^0-9]*([0-9,]+)') {
            $orig = [int]($matches[1] -replace ",", "")
        }
        return @{ Price=$price; Orig=$orig }
    } catch {
        return @{ Price=0; Orig=0 }
    }
}

$b1Prices = @{}
foreach ($row in $csvBatch1) {
    # skip row 23 since we deleted it
    if ($row.Index -eq 23) { continue }
    $p = Fetch-CleanPrice $row.ResolvedUrl
    $b1Prices[$row.Index] = $p
    Write-Output "Batch1 [$($row.Index)] $($row.Asin) -> Price: Rs $($p.Price) | MRP: Rs $($p.Orig)"
}

$b1Prices | Export-Clixml -Path "C:\Users\Pradnya Rode\OneDrive\Desktop\VS CODE\my shop\New folder\b1_prices.xml"

