Add-Type -AssemblyName System.IO.Compression.FileSystem
$docxPath = "C:\Users\Pradnya Rode\OneDrive\Desktop\VS CODE\my shop\New folder\https.docx"
$outDir = "C:\Users\Pradnya Rode\OneDrive\Desktop\VS CODE\my shop\images"
$zip = [System.IO.Compression.ZipFile]::OpenRead($docxPath)

# Extract image1.png
$entry1 = $zip.GetEntry("word/media/image1.png")
$stream1 = $entry1.Open()
$fs1 = [System.IO.File]::Create("$outDir\product15.png")
$stream1.CopyTo($fs1)
$fs1.Close()
$stream1.Close()
Write-Output "Extracted image1.png -> product15.png"

# Extract image2.png
$entry2 = $zip.GetEntry("word/media/image2.png")
$stream2 = $entry2.Open()
$fs2 = [System.IO.File]::Create("$outDir\product16.png")
$stream2.CopyTo($fs2)
$fs2.Close()
$stream2.Close()
Write-Output "Extracted image2.png -> product16.png"

$zip.Dispose()

