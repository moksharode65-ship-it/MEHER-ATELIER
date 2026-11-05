Add-Type -AssemblyName System.IO.Compression.FileSystem
$docxPath = "C:\Users\Pradnya Rode\OneDrive\Desktop\VS CODE\my shop\New folder\https.docx"
$outDir = "C:\Users\Pradnya Rode\OneDrive\Desktop\VS CODE\my shop\images"
$zip = [System.IO.Compression.ZipFile]::OpenRead($docxPath)
for ($i=1; $i -le 26; $i++) {
    $entry = $zip.GetEntry("word/media/image$i.png")
    if ($entry) {
        $stream = $entry.Open()
        $fs = [System.IO.File]::Create("$outDir\product$i.png")
        $stream.CopyTo($fs)
        $fs.Close()
        $stream.Close()
        Write-Output "Extracted image$i.png -> product$i.png"
    }
}
$zip.Dispose()