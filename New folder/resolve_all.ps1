$links = @(
    "https://link.amazon/B0dI7DA9e",
    "https://link.amazon/B03TIl7go",
    "https://link.amazon/B08n3QCMX",
    "https://link.amazon/B08LWqwBo",
    "https://link.amazon/B01Zxu0vk",
    "https://link.amazon/B00vl8whI",
    "https://link.amazon/B03fJSFLt",
    "https://link.amazon/B0aWOP16j",
    "https://link.amazon/B0cOuMlPs",
    "https://link.amazon/B01XDSyIq",
    "https://link.amazon/B0h4wowRZ",
    "https://link.amazon/B00heV88X",
    "https://link.amazon/B0ayksjpI",
    "https://link.amazon/B0hfxDM73",
    "https://link.amazon/B0eH2Mf4Z",
    "https://link.amazon/B0hxO65WT",
    "https://link.amazon/B0brVvHmE",
    "https://link.amazon/B07YlY3f4",
    "https://link.amazon/B06TGOsmQ",
    "https://link.amazon/B0ia6KojP",
    "https://link.amazon/B08nFsQPl",
    "https://link.amazon/B051yGU6P",
    "https://link.amazon/B09A9SxnV",
    "https://link.amazon/B03hRUWxj",
    "https://link.amazon/B0i6lCwDx",
    "https://link.amazon/B0g6ZDrUl",
    "https://link.amazon/B0hKGk1dj",
    "https://link.amazon/B0iDQPHqY"
)

function Resolve-FinalUrl($url) {
    $curr = $url
    $hops = 0
    while ($hops -lt 5) {
        $hops++
        try {
            $req = [System.Net.HttpWebRequest]::Create($curr)
            $req.AllowAutoRedirect = $false
            $req.Timeout = 5000
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
            return "ERROR: $($_.Exception.Message)"
        }
    }
    return $curr
}

$results = @()
for ($i = 0; $i -lt $links.Count; $i++) {
    $imgNum = $i + 1
    $link = $links[$i]
    $resolved = Resolve-FinalUrl $link
    $asin = ""
    $cat = ""
    if ($resolved -match "/dp/([A-Z0-9]{10})") {
        $asin = $matches[1]
    }
    if ($resolved -match "s=([^&]+)") {
        $cat = $matches[1]
    }
    $results += [PSCustomObject]@{
        Index = $imgNum
        ShortUrl = $link
        Image = "catalog_$imgNum.png"
        ResolvedUrl = $resolved
        Asin = $asin
        CategoryParam = $cat
    }
    Write-Output "[$imgNum] ASIN: $asin | Cat: $cat | URL: $resolved"
}

$results | Export-Csv -Path "C:\Users\Pradnya Rode\OneDrive\Desktop\VS CODE\my shop\New folder\resolved_catalog.csv" -NoTypeInformation

