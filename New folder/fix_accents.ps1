$appJsPath = "C:\Users\Pradnya Rode\OneDrive\Desktop\VS CODE\my shop\app.js"
$content = Get-Content $appJsPath -Raw -Encoding UTF8

$content = $content.Replace("LakmAc", "Lakme")
$content = $content.Replace("LakmÃ©", "Lakme")
$content = $content.Replace("Lakmé", "Lakme")
$content = $content.Replace("RENA%E", "RENEE")
$content = $content.Replace("RENÃ‰E", "RENEE")
$content = $content.Replace("RENÉE", "RENEE")

$content | Set-Content $appJsPath -Encoding UTF8
Write-Output "Cleaned up accented brand names."

