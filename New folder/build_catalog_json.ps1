$csv = Import-Csv "C:\Users\Pradnya Rode\OneDrive\Desktop\VS CODE\my shop\New folder\resolved_catalog.csv"

function Fetch-Title($url) {
    try {
        $req = [System.Net.HttpWebRequest]::Create($url)
        $req.Timeout = 6000
        $req.UserAgent = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36"
        $resp = $req.GetResponse()
        $sr = New-Object System.IO.StreamReader($resp.GetResponseStream())
        $html = $sr.ReadToEnd()
        $sr.Close()
        $resp.Close()
        
        if ($html -match "<title>(.*?)</title>") {
            $t = $matches[1] -replace "Amazon\.in: Buy\s*", "" -replace "Online at Low Prices in India - Amazon\.in", "" -replace "Amazon\.in:\s*", "" -replace ": Amazon\.in.*", "" -replace "Buy\s*", ""
            return $t.Trim()
        }
    } catch {
        return ""
    }
    return ""
}

$catalog = @()
for ($i = 0; $i -lt $csv.Count; $i++) {
    $row = $csv[$i]
    $num = $row.Index
    $asin = $row.Asin
    $url = $row.ResolvedUrl
    $short = $row.ShortUrl
    $img = "images/catalog/catalog_$num.png"
    
    $cleanTitle = ""
    if ($url -match "amazon\.in/([^/]+)/dp/") {
        $raw = $matches[1]
        $cleanTitle = [System.Uri]::UnescapeDataString($raw) -replace "-", " "
    }
    
    # Clean up title formatting
    $cleanTitle = (Get-Culture).TextInfo.ToTitleCase($cleanTitle.ToLower())
    
    $catalog += [PSCustomObject]@{
        Index = $num
        Asin = $asin
        ShortUrl = $short
        Image = $img
        Title = $cleanTitle
        RawUrl = $url
    }
}

$catalog | Export-Csv -Path "C:\Users\Pradnya Rode\OneDrive\Desktop\VS CODE\my shop\New folder\catalog_full.csv" -NoTypeInformation
Write-Output "Processed $($catalog.Count) catalog items."

