# Get current images in products
$appJs = Get-Content "c:\Users\Pradnya Rode\OneDrive\Desktop\VS CODE\my shop\app.js" -Raw -Encoding UTF8
$currentImages = [regex]::Matches($appJs, "image:\s*['""]([^'""]+)['""]") | ForEach-Object { $_.Groups[1].Value }

Write-Output "=== CURRENT IMAGES USED IN APP.JS ($($currentImages.Count)) ==="
$currentHashes = @{}
foreach ($img in $currentImages) {
    $full = "c:\Users\Pradnya Rode\OneDrive\Desktop\VS CODE\my shop\$img"
    if (Test-Path $full) {
        $h = (Get-FileHash $full -Algorithm MD5).Hash
        $currentHashes[$h] = $img
    }
}

# Now inspect image1.png to image14.png
Write-Output ""
Write-Output "=== ORIGINAL image1.png to image14.png ==="
for ($i=1; $i -le 14; $i++) {
    $file = "images/image$i.png"
    $full = "c:\Users\Pradnya Rode\OneDrive\Desktop\VS CODE\my shop\$file"
    if (Test-Path $full) {
        $h = (Get-FileHash $full -Algorithm MD5).Hash
        $isUsed = $currentHashes.ContainsKey($h)
        Write-Output "image$i.png -> InCatalog: $isUsed (Matches: $($currentHashes[$h]))"
    }
}

