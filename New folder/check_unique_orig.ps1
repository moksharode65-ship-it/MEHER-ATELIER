$appJs = Get-Content "c:\Users\Pradnya Rode\OneDrive\Desktop\VS CODE\my shop\app.js" -Raw -Encoding UTF8
$currentImages = [regex]::Matches($appJs, "image:\s*['""]([^'""]+)['""]") | ForEach-Object { $_.Groups[1].Value }

$currentHashes = @{}
foreach ($img in $currentImages) {
    $full = "c:\Users\Pradnya Rode\OneDrive\Desktop\VS CODE\my shop\$img"
    if (Test-Path $full) {
        $h = (Get-FileHash $full -Algorithm MD5).Hash
        $currentHashes[$h] = $img
    }
}

$origXml = Import-Clixml "c:\Users\Pradnya Rode\OneDrive\Desktop\VS CODE\my shop\New folder\orig_14_resolved.xml"

# Map the 14 original blocks
$origTxt = Get-Content "c:\Users\Pradnya Rode\OneDrive\Desktop\VS CODE\my shop\New folder\orig_products_only.txt" -Raw -Encoding UTF8
$blocks = [regex]::Matches($origTxt, '(?s)\{\s*id:\s*''meher-(\d+)''.*?sizes:\s*\[.*?\]\s*\}')

$toAdd = @()
for ($i=0; $i -lt $origXml.Count; $i++) {
    $num = $i + 1
    $imgFile = "images/image$num.png"
    $fullImg = "c:\Users\Pradnya Rode\OneDrive\Desktop\VS CODE\my shop\$imgFile"
    $h = (Get-FileHash $fullImg -Algorithm MD5).Hash
    
    if (-not $currentHashes.ContainsKey($h)) {
        $info = $origXml[$i]
        $block = $blocks[$i].Value
        
        # update price in block
        $block = $block -replace "id:\s*'meher-\d+'", "id: 'meher-orig-$num'"
        if ($info.Price -gt 0) {
            $block = $block -replace "price:\s*\d+", "price: $($info.Price)"
        }
        if ($info.Orig -gt 0) {
            $block = $block -replace "originalPrice:\s*\d+", "originalPrice: $($info.Orig)"
        }
        
        $toAdd += $block.Trim()
        Write-Output "Adding unique original item: ASIN $($info.Asin) | Price $($info.Price)"
    }
}

Write-Output "TOTAL UNIQUE ORIGINAL PRODUCTS TO ADD: $($toAdd.Count)"
$toAdd | Out-File "c:\Users\Pradnya Rode\OneDrive\Desktop\VS CODE\my shop\New folder\unique_orig_blocks.txt" -Encoding UTF8
