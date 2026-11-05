Add-Type -AssemblyName System.IO.Compression.FileSystem
$docxPath = "C:\Users\Pradnya Rode\OneDrive\Desktop\VS CODE\my shop\New folder\https.docx"
$zip = [System.IO.Compression.ZipFile]::OpenRead($docxPath)

# List all entries in the docx zip
Write-Output "=== FILES IN DOCX ==="
foreach ($e in $zip.Entries) {
    Write-Output "$($e.FullName) ($($e.Length) bytes)"
}

# Extract document.xml with relationships
Write-Output ""
Write-Output "=== DOCUMENT.XML FULL CONTENT ==="
$entry = $zip.GetEntry("word/document.xml")
$sr = New-Object System.IO.StreamReader($entry.Open())
$content = $sr.ReadToEnd()
$sr.Close()
Write-Output $content

# Extract relationships
Write-Output ""
Write-Output "=== RELATIONSHIPS ==="
$relsEntry = $zip.GetEntry("word/_rels/document.xml.rels")
if ($relsEntry) {
    $sr2 = New-Object System.IO.StreamReader($relsEntry.Open())
    $rels = $sr2.ReadToEnd()
    $sr2.Close()
    Write-Output $rels
}

$zip.Dispose()

