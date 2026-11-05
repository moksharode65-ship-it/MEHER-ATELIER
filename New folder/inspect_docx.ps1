Add-Type -AssemblyName System.IO.Compression.FileSystem
$docxPath = "C:\Users\Pradnya Rode\OneDrive\Desktop\VS CODE\my shop\New folder\https.docx"
$tempPath = "C:\Users\Pradnya Rode\OneDrive\Desktop\VS CODE\my shop\New folder\https_temp.docx"

# Copy with FileShare.ReadWrite to avoid locking issues if open in Word
$srcStream = New-Object System.IO.FileStream($docxPath, [System.IO.FileMode]::Open, [System.IO.FileAccess]::Read, [System.IO.FileShare]::ReadWrite)
$dstStream = New-Object System.IO.FileStream($tempPath, [System.IO.FileMode]::Create, [System.IO.FileAccess]::Write)
$srcStream.CopyTo($dstStream)
$dstStream.Close()
$srcStream.Close()

$zip = [System.IO.Compression.ZipFile]::OpenRead($tempPath)

Write-Output "=== FILES IN DOCX ==="
foreach ($e in $zip.Entries) {
    Write-Output "$($e.FullName) ($($e.Length) bytes)"
}

Write-Output ""
Write-Output "=== DOCUMENT.XML FULL CONTENT ==="
$entry = $zip.GetEntry("word/document.xml")
$sr = New-Object System.IO.StreamReader($entry.Open())
$content = $sr.ReadToEnd()
$sr.Close()
Write-Output $content

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
Remove-Item $tempPath -Force

