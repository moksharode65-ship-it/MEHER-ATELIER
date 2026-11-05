# Fetch actual prices from Amazon product pages for the new 28 products
$asins = @(
    @{Index=1; Asin="B0CSK7YP3H"; Short="https://link.amazon/B0dI7DA9e"},
    @{Index=2; Asin="B018QGPOMI"; Short="https://link.amazon/B03TIl7go"},
    @{Index=20; Asin="B0HFSGP4ZH"; Short="https://link.amazon/B0ia6KojP"},
    @{Index=23; Asin="B0HFSLY62Z"; Short="https://link.amazon/B09A9SxnV"}
)

function Get-Price($url) {
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

        # Try to extract price
        $prices = @()
        if ($html -match '"priceAmount":(\d+\.?\d*)') { $prices += [decimal]$matches[1] }
        if ($html -match '"price":\s*"?(\d+\.?\d*)"?') { $prices += [decimal]$matches[1] }
        if ($html -match 'class="a-price-whole">(\d+)') { $prices += [decimal]$matches[1] }
        if ($prices.Count -gt 0) { return ($prices | Measure-Object -Minimum).Minimum }
        return "NOT_FOUND"
    } catch {
        return "ERROR: $($_.Exception.Message.Substring(0, [Math]::Min(60, $_.Exception.Message.Length)))"
    }
}

foreach ($item in $asins) {
    $price = Get-Price $item.Short
    Write-Output "[$($item.Index)] ASIN: $($item.Asin) | Price: Rs $price"
}

