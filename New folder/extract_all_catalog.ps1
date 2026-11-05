Add-Type -AssemblyName System.IO.Compression.FileSystem
$docxPath = "C:\Users\Pradnya Rode\OneDrive\Desktop\VS CODE\my shop\New folder\https.docx"
$tempPath = "C:\Users\Pradnya Rode\OneDrive\Desktop\VS CODE\my shop\New folder\https_temp_extract_all.docx"
$outDir = "C:\Users\Pradnya Rode\OneDrive\Desktop\VS CODE\my shop\images\catalog"

if (!(Test-Path $outDir)) {
    New-Item -ItemType Directory -Path $outDir -Force | Out-Null
}

$srcStream = New-Object System.IO.FileStream($docxPath, [System.IO.FileMode]::Open, [System.IO.FileAccess]::Read, [System.IO.FileShare]::ReadWrite)
$dstStream = New-Object System.IO.FileStream($tempPath, [System.IO.FileMode]::Create, [System.IO.FileAccess]::Write)
$srcStream.CopyTo($dstStream)
$dstStream.Close()
$srcStream.Close()

$zip = [System.IO.Compression.ZipFile]::OpenRead($tempPath)

# Extract images 1 to 28
for ($i = 1; $i -le 28; $i++) {
    $entryName = "word/media/image$i.png"
    $entry = $zip.GetEntry($entryName)
    if ($entry) {
        $outPath = "$outDir\catalog_$i.png"
        $stream = $entry.Open()
        $fs = [System.IO.File]::Create($outPath)
        $stream.CopyTo($fs)
        $fs.Close()
        $stream.Close()
        Write-Output "Saved catalog_$i.png"
    } else {
        Write-Warning "Missing $entryName"
    }
}

$zip.Dispose()
Remove-Item $tempPath -Force

