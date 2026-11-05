# Fetch actual live prices for the 14 original items
$origTxt = Get-Content "c:\Users\Pradnya Rode\OneDrive\Desktop\VS CODE\my shop\New folder\orig_products_only.txt" -Raw -Encoding UTF8

$blocks = [regex]::Matches($origTxt, '(?s)\{\s*id:\s*''meher-(\d+)''.*?sizes:\s*\[.*?\]\s*\}')

function Get-LivePrice($asin) {
    $url = "https://www.amazon.in/dp/$asin?tag=moksharode073-21"
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

Write-Output "Found $($blocks.Count) original product blocks."

$liveOrig = @()
foreach ($m in $blocks) {
    $txt = $m.Value
    $asin = if ($txt -match "asin:\s*'([^']+)'") { $matches[1] } else { "" }
    $title = if ($txt -match 'title:\s*"([^"]+)"') { $matches[1] } else { "" }
    $p = Get-LivePrice $asin
    Write-Output "ASIN: $asin | Price: Rs $($p.Price) | Title: $title"
    $liveOrig += [PSCustomObject]@{
        Asin = $asin
        Title = $title
        Price = $p.Price
        Orig = $p.Orig
        RawBlock = $txt
    }
}

$liveOrig | Export-Clixml -Path "c:\Users\Pradnya Rode\OneDrive\Desktop\VS CODE\my shop\New folder\orig_live_prices.xml"

