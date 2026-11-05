# Compare images and find files in 'images' that are unique
$allImages = Get-ChildItem "c:\Users\Pradnya Rode\OneDrive\Desktop\VS CODE\my shop\images" -Recurse -File | Where-Object { $_.Extension -match 'png|jpg|jpeg' }

$hashes = @{}
foreach ($img in $allImages) {
    $h = (Get-FileHash -Path $img.FullName -Algorithm MD5).Hash
    if (-not $hashes.ContainsKey($h)) {
        $hashes[$h] = @()
    }
    $hashes[$h] += $img.FullName.Replace("c:\Users\Pradnya Rode\OneDrive\Desktop\VS CODE\my shop\", "")
}

Write-Output "TOTAL FILES: $($allImages.Count) | UNIQUE IMAGES: $($hashes.Keys.Count)"
$i = 0
foreach ($k in $hashes.Keys) {
    $i++
    $files = $hashes[$k]
    Write-Output "[$i] Unique Hash $k : $($files -join '  <=>  ')"
}

