$links = @(
    @{Index=1; Short="https://link.amazon/B0hjcozbk"; Image="images/batch2/new_1.png"},
    @{Index=2; Short="https://link.amazon/B00YqlZX2"; Image="images/batch2/new_2.png"},
    @{Index=3; Short="https://link.amazon/B0aawP0NO"; Image="images/batch2/new_3.png"},
    @{Index=4; Short="https://link.amazon/B0dPSeHVh"; Image="images/batch2/new_4.png"},
    @{Index=5; Short="https://link.amazon/B09XnYCSu"; Image="images/batch2/new_5.png"},
    @{Index=6; Short="https://link.amazon/B00c3Z6DV"; Image="images/batch2/new_6.png"},
    @{Index=7; Short="https://link.amazon/B05mA478I"; Image="images/batch2/new_7.png"},
    @{Index=8; Short="https://link.amazon/B02ciFdIX"; Image="images/batch2/new_8.png"},
    @{Index=9; Short="https://link.amazon/B0eG9yvHi"; Image="images/batch2/new_9.png"},
    @{Index=10; Short="https://link.amazon/B0iJSBPY3"; Image="images/batch2/new_10.png"},
    @{Index=11; Short="https://link.amazon/B08U3kjJL"; Image="images/batch2/new_11.png"}
)

function Resolve-FinalUrl($url) {
    $curr = $url
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

$results = @()
foreach ($item in $links) {
    $finalUrl = Resolve-FinalUrl $item.Short
    $asin = ""
    if ($finalUrl -match "/dp/([A-Z0-9]{10})") {
        $asin = $matches[1]
    }
    $titleSlug = ""
    if ($finalUrl -match "amazon\.in/([^/]+)/dp/") {
        $titleSlug = [System.Uri]::UnescapeDataString($matches[1]) -replace "-", " "
    }
    
    $obj = [PSCustomObject]@{
        Index = $item.Index
        Asin = $asin
        Short = $item.Short
        Image = $item.Image
        TitleSlug = $titleSlug
        FinalUrl = $finalUrl
    }
    $results += $obj
    Write-Output "[$($item.Index)] ASIN: $asin | TitleSlug: $titleSlug"
}

$results | Export-Csv -Path "C:\Users\Pradnya Rode\OneDrive\Desktop\VS CODE\my shop\New folder\batch2_resolved.csv" -NoTypeInformation

