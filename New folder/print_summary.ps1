$csv = Import-Csv "C:\Users\Pradnya Rode\OneDrive\Desktop\VS CODE\my shop\New folder\resolved_catalog.csv"

foreach ($row in $csv) {
    $title = ""
    if ($row.ResolvedUrl -match "amazon\.in/([^/]+)/dp/") {
        $raw = $matches[1]
        $title = [System.Uri]::UnescapeDataString($raw) -replace "-", " "
    } elseif ($row.ResolvedUrl -match "/dp/([A-Z0-9]+)") {
        $title = "Product " + $matches[1]
    }
    Write-Output "[$($row.Index)] ASIN: $($row.Asin) | Image: $($row.Image) | Title: $title"
}

