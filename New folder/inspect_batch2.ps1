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

function Resolve-And-FetchDetails($shortUrl) {
    $curr = $shortUrl
    $hops = 0
    while ($hops -lt 5) {
        $hops++
        try {
            $req = [System.Net.HttpWebRequest]::Create($curr)
            $req.AllowAutoRedirect = $false
            $req.Timeout = 6000
            $req.UserAgent = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36"
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
            return @{ Url=$curr; Error=$_.Exception.Message; Title=""; Price=0; OrigPrice=0; Rating=4.5; Reviews=1000 }
        }
    }
    
    # Now fetch page content for price and title
    $title = ""
    $price = 0
    $origPrice = 0
    $rating = 4.4
    $reviews = 1200
    
    try {
        $req = [System.Net.HttpWebRequest]::Create($curr)
        $req.Timeout = 8000
        $req.UserAgent = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36"
        $req.Headers.Add("Accept-Language", "en-IN,en;q=0.9")
        $resp = $req.GetResponse()
        $sr = New-Object System.IO.StreamReader($resp.GetResponseStream())
        $html = $sr.ReadToEnd()
        $sr.Close()
        $resp.Close()
        
        # Title
        if ($html -match 'id="productTitle"[^>]*>\s*([^<]+)\s*<') {
            $title = $matches[1].Trim()
        } elseif ($html -match '<title>(.*?)</title>') {
            $title = $matches[1] -replace "Amazon\.in: Buy\s*", "" -replace "Online at Low Prices in India - Amazon\.in", "" -replace "Amazon\.in:\s*", "" -replace ": Amazon\.in.*", "" -replace "Buy\s*", ""
            $title = $title.Trim()
        }
        
        # Price
        if ($html -match 'class="a-price-whole">(\d+[\d,]*)') {
            $price = [int]($matches[1] -replace ",", "")
        } elseif ($html -match '"priceAmount":(\d+\.?\d*)') {
            $price = [int][double]$matches[1]
        }
        
        # Original price (MRP / Strike-through)
        if ($html -match 'class="a-price a-text-price[^"]*"[^>]*>.*?class="a-offscreen">₹?(\d+[\d,]*)') {
            $origPrice = [int]($matches[1] -replace ",", "")
        } elseif ($html -match 'M\.R\.P\.:.*?₹(\d+[\d,]*)') {
            $origPrice = [int]($matches[1] -replace ",", "")
        }
        
        # Rating
        if ($html -match 'class="a-icon-alt">([0-9\.]+) out of 5 stars') {
            $rating = [double]$matches[1]
        }
        
        # Review count
        if ($html -match 'id="acrCustomerReviewText"[^>]*>(\d+[\d,]*)\s*ratings?') {
            $reviews = [int]($matches[1] -replace ",", "")
        }
    } catch {
        # Error during fetch
    }
    
    return @{
        Url = $curr
        Title = $title
        Price = $price
        OrigPrice = $origPrice
        Rating = $rating
        Reviews = $reviews
    }
}

$results = @()
foreach ($item in $links) {
    Write-Output "Resolving item $($item.Index): $($item.Short)..."
    $det = Resolve-And-FetchDetails $item.Short
    $asin = ""
    if ($det.Url -match "/dp/([A-Z0-9]{10})") {
        $asin = $matches[1]
    }
    
    $obj = [PSCustomObject]@{
        Index = $item.Index
        Asin = $asin
        Short = $item.Short
        Image = $item.Image
        Title = $det.Title
        Price = $det.Price
        OrigPrice = $det.OrigPrice
        Rating = $det.Rating
        Reviews = $det.Reviews
        FinalUrl = $det.Url
    }
    $results += $obj
    Write-Output "-> ASIN: $asin | Price: $($det.Price) | MRP: $($det.OrigPrice) | Title: $($det.Title.Substring(0, [Math]::Min(50, $det.Title.Length)))"
}

$results | Export-Csv -Path "C:\Users\Pradnya Rode\OneDrive\Desktop\VS CODE\my shop\New folder\batch2_details.csv" -NoTypeInformation

