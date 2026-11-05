$origApp = Get-Content "c:\Users\Pradnya Rode\OneDrive\Desktop\VS CODE\my shop\New folder\orig_app.js" -Raw -Encoding UTF8
$pattern = '(?s)const products = \[(.*?)\];\s*(?=\r?\n// State)'

if ($origApp -match $pattern) {
    Write-Output "Found products block!"
    $Matches[1] | Out-File "c:\Users\Pradnya Rode\OneDrive\Desktop\VS CODE\my shop\New folder\orig_products_only.txt" -Encoding UTF8
}

