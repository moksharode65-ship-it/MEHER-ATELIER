$appJsPath = "c:\Users\Pradnya Rode\OneDrive\Desktop\VS CODE\my shop\app.js"
$content = Get-Content $appJsPath -Raw -Encoding UTF8

# Fix garbled title for meher-1
$content = $content -replace 'Engage Luxury Perfume Gift Set for Women â€" 4 Premium Fragrances', 'Engage Luxury Perfume Gift Set for Women — 4 Premium Fragrances'

# Fix prices based on actual Amazon prices fetched:
# meher-1 (B0CSK7YP3H): actual price Rs 299, original ~599
$content = $content -replace "(?s)(id: 'meher-1'.*?price: )899(.*?originalPrice: )1499", "`${1}299`${2}599"

# meher-2 (B018QGPOMI): actual price Rs 168, original ~300
$content = $content -replace "(?s)(id: 'meher-2'.*?price: )249(.*?originalPrice: )425", "`${1}168`${2}300"

# meher-20 (B0HFSGP4ZH): actual price Rs 769, original ~1799
$content = $content -replace "(?s)(id: 'meher-20'.*?price: )549(.*?originalPrice: )1799", "`${1}769`${2}1799"

$content | Set-Content $appJsPath -Encoding UTF8
Write-Output "Prices and title fixed successfully."

