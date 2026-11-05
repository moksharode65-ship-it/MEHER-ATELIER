Add-Type -AssemblyName System.IO.Compression.FileSystem
$docxPath = "C:\Users\Pradnya Rode\OneDrive\Desktop\VS CODE\my shop\New folder\https.docx"
$zip = [System.IO.Compression.ZipFile]::OpenRead($docxPath)
$entry = $zip.GetEntry("word/document.xml")
$sr = New-Object System.IO.StreamReader($entry.Open())
$content = $sr.ReadToEnd()
$sr.Close()
$zip.Dispose()

# Parse XML and extract text
$xmlDoc = [xml]$content
$ns = New-Object System.Xml.XmlNamespaceManager($xmlDoc.NameTable)
$ns.AddNamespace("w", "http://schemas.openxmlformats.org/wordprocessingml/2006/main")
$paragraphs = $xmlDoc.SelectNodes("//w:p", $ns)

foreach ($p in $paragraphs) {
    $texts = $p.SelectNodes(".//w:t", $ns)
    $line = ""
    foreach ($t in $texts) {
        $line += $t.InnerText
    }
    if ($line.Trim() -ne "") {
        Write-Output $line
    }
}

