$appJsPath = "c:\Users\Pradnya Rode\OneDrive\Desktop\VS CODE\my shop\app.js"
$bytes = [System.IO.File]::ReadAllBytes($appJsPath)
$text = [System.Text.Encoding]::UTF8.GetString($bytes)

# Fix garbled em-dash in title
$text = $text.Replace("â€"", [char]8212)

# Fix prices for meher-1: price 899->299, originalPrice 1499->599
$text = $text -replace "(id: 'meher-1'(?:.|\n){1,200}?)price: 899", "`$1price: 299"
$text = $text -replace "(id: 'meher-1'(?:.|\n){1,250}?)originalPrice: 1499", "`$1originalPrice: 599"

# Fix prices for meher-2: price 249->168, originalPrice 425->300
$text = $text -replace "(id: 'meher-2'(?:.|\n){1,200}?)price: 249", "`$1price: 168"
$text = $text -replace "(id: 'meher-2'(?:.|\n){1,250}?)originalPrice: 425", "`$1originalPrice: 300"

# Fix prices for meher-20: price 549->769
$text = $text -replace "(id: 'meher-20'(?:.|\n){1,200}?)price: 549", "`$1price: 769"
# originalPrice 1799 is correct, no change needed

[System.IO.File]::WriteAllText($appJsPath, $text, [System.Text.Encoding]::UTF8)
Write-Output "Done. Prices and encoding fixed."

