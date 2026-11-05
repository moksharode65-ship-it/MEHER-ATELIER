Add-Type -AssemblyName System.IO.Compression.FileSystem
$docxPath = "C:\Users\Pradnya Rode\OneDrive\Desktop\VS CODE\my shop\New folder\https.docx"
$tempPath = "C:\Users\Pradnya Rode\OneDrive\Desktop\VS CODE\my shop\New folder\https_temp_parse.docx"

$srcStream = New-Object System.IO.FileStream($docxPath, [System.IO.FileMode]::Open, [System.IO.FileAccess]::Read, [System.IO.FileShare]::ReadWrite)
$dstStream = New-Object System.IO.FileStream($tempPath, [System.IO.FileMode]::Create, [System.IO.FileAccess]::Write)
$srcStream.CopyTo($dstStream)
$dstStream.Close()
$srcStream.Close()

$zip = [System.IO.Compression.ZipFile]::OpenRead($tempPath)

# Read relationships
$relsEntry = $zip.GetEntry("word/_rels/document.xml.rels")
$srRels = New-Object System.IO.StreamReader($relsEntry.Open())
$relsXml = [xml]$srRels.ReadToEnd()
$srRels.Close()

$relMap = @{}
foreach ($rel in $relsXml.Relationships.Relationship) {
    $relMap[$rel.Id] = @{
        Type = $rel.Type
        Target = $rel.Target
    }
}

# Read document.xml
$docEntry = $zip.GetEntry("word/document.xml")
$srDoc = New-Object System.IO.StreamReader($docEntry.Open())
$docXml = [xml]$srDoc.ReadToEnd()
$srDoc.Close()

$ns = New-Object System.Xml.XmlNamespaceManager($docXml.NameTable)
$ns.AddNamespace("w", "http://schemas.openxmlformats.org/wordprocessingml/2006/main")
$ns.AddNamespace("r", "http://schemas.openxmlformats.org/officeDocument/2006/relationships")
$ns.AddNamespace("a", "http://schemas.openxmlformats.org/drawingml/2006/main")

$paragraphs = $docXml.SelectNodes("//w:p", $ns)

$items = @()
$counter = 0

foreach ($p in $paragraphs) {
    # Check hyperlinks or text for URLs
    $link = ""
    $hl = $p.SelectSingleNode(".//w:hyperlink", $ns)
    if ($hl -and $hl.GetAttribute("r:id")) {
        $rId = $hl.GetAttribute("r:id")
        if ($relMap.ContainsKey($rId)) {
            $link = $relMap[$rId].Target
        }
    }
    
    # Or text containing https
    $texts = $p.SelectNodes(".//w:t", $ns)
    $fullText = ""
    foreach ($t in $texts) { $fullText += $t.InnerText }
    
    if (-not $link) {
        $regex = [regex]::Match($fullText, "https?://\S+")
        if ($regex.Success) {
            $link = $regex.Value
        }
    }
    
    # Check for images in this paragraph
    $blips = $p.SelectNodes(".//a:blip", $ns)
    $imageTargets = @()
    foreach ($blip in $blips) {
        $imgRid = $blip.GetAttribute("r:embed")
        if ($imgRid -and $relMap.ContainsKey($imgRid)) {
            $imageTargets += $relMap[$imgRid].Target
        }
    }
    
    if ($link -or $imageTargets.Count -gt 0 -or $fullText.Trim()) {
        $counter++
        Write-Output "ITEM $counter : Text='$($fullText.Trim())' | Link='$link' | Images=$($imageTargets -join ',')"
    }
}

$zip.Dispose()
Remove-Item $tempPath -Force

