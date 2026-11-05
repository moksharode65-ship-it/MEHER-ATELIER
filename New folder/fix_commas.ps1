$appJsPath = "C:\Users\Pradnya Rode\OneDrive\Desktop\VS CODE\my shop\app.js"
$content = Get-Content $appJsPath -Raw -Encoding UTF8

# Fix missing commas: when '}' is followed by optional whitespace and '{'
$fixed = [regex]::Replace($content, '(\})\s*(\r?\n\s*\{)', '$1,$2')

$fixed | Set-Content $appJsPath -Encoding UTF8
Write-Output "Fixed commas in app.js!"

