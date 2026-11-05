$origTxt = Get-Content "c:\Users\Pradnya Rode\OneDrive\Desktop\VS CODE\my shop\New folder\orig_products_only.txt" -Raw -Encoding UTF8
$shorts = [regex]::Matches($origTxt, "shortUrl:\s*'([^']+)'") | ForEach-Object { $_.Groups[1].Value }

function Follow-Hops($shortUrl) {
    $curr = $shortUrl
    $hops = 0
    while ($hops -lt 5) {
        $hops++
        try {
            $req = [System.Net.HttpWebRequest]::Create($curr)
            $req.AllowAutoRedirect = $false
            $req.Timeout = 6000
            $req.UserAgent = "Mozilla/5.0 (Windows NT 10.0; Win64; x64)"
            $resp = $req.GetResponse()
            $status = [int]$resp.StatusCode
            if ($status -ge 300 -and $status -lt 400) {
                $curr = $resp.GetResponseHeader("Location")
                $resp.Close()
            } else {
                $resp.Close()
                break
            }
        } catch {
            return $curr
        }
    }
    return $curr
}

function Get-PriceFromHtml($url) {
    try {
        $req = [System.Net.HttpWebRequest]::Create($url)
        $req.Timeout = 8000
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
        }
        $orig = 0
        if ($html -match 'class="a-price a-text-price[^"]*"[^>]*>.*?class="a-offscreen">[^0-9]*([0-9,]+)') {
            $orig = [int]($matches[1] -replace ",", "")
        }
        return @{ Price=$price; Orig=$orig }
    } catch {
        return @{ Price=0; Orig=0 }
    }
}

$results = @()
for ($i=0; $i -lt $shorts.Count; $i++) {
    $s = $shorts[$i]
    $fin = Follow-Hops $s
    $p = Get-PriceFromHtml $fin
    $asin = if ($fin -match "/dp/([A-Z0-9]{10})") { $matches[1] } else { "" }
    Write-Output "[$($i+1)] ASIN: $asin | Price: Rs $($p.Price) | MRP: Rs $($p.Orig) | URL: $($fin.Substring(0, [Math]::Min(60, $fin.Length)))"
    $results += [PSCustomObject]@{
        Index = $i + 1
        Short = $s
        FinalUrl = $fin
        Asin = $asin
        Price = $p.Price
        Orig = $p.Orig
    }
}

$results | Export-Clixml -Path "c:\Users\Pradnya Rode\OneDrive\Desktop\VS CODE\my shop\New folder\orig_14_resolved.xml"

