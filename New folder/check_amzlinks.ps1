$url = "https://amzlinks.in/B0dI7DA9e"
try {
    $req = [System.Net.HttpWebRequest]::Create($url)
    $req.AllowAutoRedirect = $false
    $req.Timeout = 5000
    $req.UserAgent = "Mozilla/5.0 (Windows NT 10.0; Win64; x64)"
    $resp = $req.GetResponse()
    $location = $resp.GetResponseHeader("Location")
    Write-Output "Status: $($resp.StatusCode) Location: $location"
    if (-not $location) {
        $sr = New-Object System.IO.StreamReader($resp.GetResponseStream())
        $body = $sr.ReadToEnd()
        $sr.Close()
        Write-Output "Body length: $($body.Length)"
        Write-Output $body.Substring(0, [System.Math]::Min(500, $body.Length))
    }
    $resp.Close()
} catch {
    Write-Output "Error: $($_.Exception.Message)"
}

