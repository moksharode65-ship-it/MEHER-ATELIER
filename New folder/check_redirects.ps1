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
    "https://link.amazon/B01XDSyIq"
)

foreach ($url in $links) {
    try {
        $req = [System.Net.HttpWebRequest]::Create($url)
        $req.AllowAutoRedirect = $false
        $req.Timeout = 5000
        $req.UserAgent = "Mozilla/5.0 (Windows NT 10.0; Win64; x64)"
        $resp = $req.GetResponse()
        $location = $resp.GetResponseHeader("Location")
        Write-Output "$url -> $location"
        $resp.Close()
    } catch {
        Write-Output "$url -> Error: $($_.Exception.Message)"
    }
}

