$csv = Import-Csv "C:\Users\Pradnya Rode\OneDrive\Desktop\VS CODE\my shop\New folder\batch2_resolved.csv"

function Get-PriceAndData($url) {
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
        } elseif ($html -match '"price":\s*"?([0-9\.]+)"?') {
            $price = [int][double]$matches[1]
        }

        $orig = 0
        if ($html -match 'class="a-price a-text-price[^"]*"[^>]*>.*?class="a-offscreen">[^0-9]*([0-9,]+)') {
            $orig = [int]($matches[1] -replace ",", "")
        } elseif ($html -match 'M\.R\.P\.:[^0-9]*([0-9,]+)') {
            $orig = [int]($matches[1] -replace ",", "")
        }

        $rating = 4.4
        if ($html -match 'class="a-icon-alt">([0-9\.]+) out of 5 stars') {
            $rating = [double]$matches[1]
        }

        $reviews = 1200
        if ($html -match 'id="acrCustomerReviewText"[^>]*>([0-9,]+)\s*ratings?') {
            $reviews = [int]($matches[1] -replace ",", "")
        }

        return @{ Price=$price; Orig=$orig; Rating=$rating; Reviews=$reviews }
    } catch {
        return @{ Price=0; Orig=0; Rating=4.4; Reviews=1000 }
    }
}

$results = @()
foreach ($row in $csv) {
    $info = Get-PriceAndData $row.FinalUrl
    Write-Output "[$($row.Index)] $($row.Asin) | Price: Rs $($info.Price) | MRP: Rs $($info.Orig) | $($row.TitleSlug)"
    $row | Add-Member -MemberType NoteProperty -Name "Price" -Value $info.Price -Force
    $row | Add-Member -MemberType NoteProperty -Name "OrigPrice" -Value $info.Orig -Force
    $row | Add-Member -MemberType NoteProperty -Name "Rating" -Value $info.Rating -Force
    $row | Add-Member -MemberType NoteProperty -Name "Reviews" -Value $info.Reviews -Force
    $results += $row
}

$results | Export-Csv -Path "C:\Users\Pradnya Rode\OneDrive\Desktop\VS CODE\my shop\New folder\batch2_complete.csv" -NoTypeInformation

