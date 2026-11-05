Add-Type -AssemblyName System.IO.Compression.FileSystem
$docxPath = "C:\Users\Pradnya Rode\OneDrive\Desktop\VS CODE\my shop\New folder\https.docx"
$tempPath = "C:\Users\Pradnya Rode\OneDrive\Desktop\VS CODE\my shop\New folder\https_temp_detail.docx"

$srcStream = New-Object System.IO.FileStream($docxPath, [System.IO.FileMode]::Open, [System.IO.FileAccess]::Read, [System.IO.FileShare]::ReadWrite)
$dstStream = New-Object System.IO.FileStream($tempPath, [System.IO.FileMode]::Create, [System.IO.FileAccess]::Write)
$srcStream.CopyTo($dstStream)
$dstStream.Close()
$srcStream.Close()

$zip = [System.IO.Compression.ZipFile]::OpenRead($tempPath)

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

$docEntry = $zip.GetEntry("word/document.xml")
$srDoc = New-Object System.IO.StreamReader($docEntry.Open())
$docXml = [xml]$srDoc.ReadToEnd()
$srDoc.Close()

$ns = New-Object System.Xml.XmlNamespaceManager($docXml.NameTable)
$ns.AddNamespace("w", "http://schemas.openxmlformats.org/wordprocessingml/2006/main")
$ns.AddNamespace("r", "http://schemas.openxmlformats.org/officeDocument/2006/relationships")
$ns.AddNamespace("a", "http://schemas.openxmlformats.org/drawingml/2006/main")
$ns.AddNamespace("wp", "http://schemas.openxmlformats.org/drawingml/2006/wordprocessingDrawing")

# Iterate through all children of w:p in order
$paragraphs = $docXml.SelectNodes("//w:p", $ns)
$sequence = @()

foreach ($p in $paragraphs) {
    foreach ($child in $p.ChildNodes) {
        if ($child.LocalName -eq "hyperlink") {
            $rId = $child.GetAttribute("r:id")
            $target = if ($relMap.ContainsKey($rId)) { $relMap[$rId].Target } else { "" }
            $text = $child.InnerText.Trim()
            $sequence += [PSCustomObject]@{ Type="Hyperlink"; Target=$target; Text=$text }
        }
        elseif ($child.LocalName -eq "r") {
            # check for text
            $t = $child.SelectNodes(".//w:t", $ns)
            $text = ""
            foreach ($tn in $t) { $text += $tn.InnerText }
            if ($text.Trim()) {
                $sequence += [PSCustomObject]@{ Type="RunText"; Target=""; Text=$text.Trim() }
            }
            # check for drawing/image
            $blips = $child.SelectNodes(".//a:blip", $ns)
            foreach ($blip in $blips) {
                $imgRid = $blip.GetAttribute("r:embed")
                $target = if ($relMap.ContainsKey($imgRid)) { $relMap[$imgRid].Target } else { "" }
                $sequence += [PSCustomObject]@{ Type="Image"; Target=$target; Text="" }
            }
        }
    }
}

$zip.Dispose()
Remove-Item $tempPath -Force

Write-Output "TOTAL ELEMENTS: $($sequence.Count)"
for ($i = 0; $i -lt $sequence.Count; $i++) {
    $item = $sequence[$i]
    Write-Output "[$i] $($item.Type): Text='$($item.Text)' Target='$($item.Target)'"
}

