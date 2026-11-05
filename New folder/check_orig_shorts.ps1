# Check actual redirection for shortlinks of the original 14
$origTxt = Get-Content "c:\Users\Pradnya Rode\OneDrive\Desktop\VS CODE\my shop\New folder\orig_products_only.txt" -Raw -Encoding UTF8
$shorts = [regex]::Matches($origTxt, "shortUrl:\s*'([^']+)'") | ForEach-Object { $_.Groups[1].Value }

function Resolve-Link($url) {
    try {
        $req = [System.Net.HttpWebRequest]::Create($url)
        $req.AllowAutoRedirect = $false
        $req.Timeout = 5000
        $req.UserAgent = "Mozilla/5.0 (Windows NT 10.0; Win64; x64)"
        $resp = $req.GetResponse()
        $loc = $resp.GetResponseHeader("Location")
        $resp.Close()
        return $loc
    } catch {
        return "ERROR: $($_.Exception.Message)"
    }
}

for ($i=0; $i -lt $shorts.Count; $i++) {
    $s = $shorts[$i]
    $r = Resolve-Link $s
    Write-Output "[$($i+1)] $s -> $r"
}

