$appJsPath = "C:\Users\Pradnya Rode\OneDrive\Desktop\VS CODE\my shop\app.js"
$appJsContent = Get-Content $appJsPath -Raw -Encoding UTF8

$finalProductsCode = Get-Content "C:\Users\Pradnya Rode\OneDrive\Desktop\VS CODE\my shop\New folder\final_arranged_products.js" -Raw -Encoding UTF8

# Replace from 'const products = [' up to '];\r?\n\r?\n// State'
$pattern = '(?s)const products = \[.*?\];\s*(?=\r?\n// State)'

if ($appJsContent -match $pattern) {
    $updatedContent = [regex]::Replace($appJsContent, $pattern, $finalProductsCode.Trim())
    $updatedContent | Out-File -FilePath $appJsPath -Encoding UTF8
    Write-Output "Successfully updated app.js with all 38 products!"
} else {
    Write-Error "Could not find products array pattern in app.js"
}

