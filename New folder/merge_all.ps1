$appJsPath = "C:\Users\Pradnya Rode\OneDrive\Desktop\VS CODE\my shop\app.js"
$appJsContent = Get-Content $appJsPath -Raw -Encoding UTF8

$uniqueOrig = Get-Content "c:\Users\Pradnya Rode\OneDrive\Desktop\VS CODE\my shop\New folder\unique_orig_blocks.txt" -Raw -Encoding UTF8
$formattedOrig = "  // --- RESTORED ORIGINAL EXCLUSIVE ETHNIC COLLECTIONS ---`r`n" + ($uniqueOrig -join ",`r`n") + ",`r`n"

# Insert right after 'const products = ['
$pattern = 'const products = \[\r?\n'

if ($appJsContent -match $pattern) {
    $updatedContent = [regex]::Replace($appJsContent, $pattern, "const products = [`r`n" + $formattedOrig, 1)
    $updatedContent | Set-Content -Path $appJsPath -Encoding UTF8
    Write-Output "Successfully merged all 14 unique original ethnic outfits into app.js!"
} else {
    Write-Error "Could not find products header in app.js"
}

