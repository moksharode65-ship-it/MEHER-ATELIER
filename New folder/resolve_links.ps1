$urls = @(
    'https://link.amazon/B08n3QCMX',
    'https://link.amazon/B08LWqwBo',
    'https://link.amazon/B01Zxu0vk',
    'https://link.amazon/B00vl8whI',
    'https://link.amazon/B03fJSFLt',
    'https://link.amazon/B0aWOP16j',
    'https://link.amazon/B0cOuMlPs',
    'https://link.amazon/B01XDSyIq',
    'https://link.amazon/B0h4wowRZ',
    'https://link.amazon/B00heV88X',
    'https://link.amazon/B0ayksjpI',
    'https://link.amazon/B0hfxDM73',
    'https://link.amazon/B0eH2Mf4Z',
    'https://link.amazon/B0hxO65WT',
    'https://link.amazon/B0brVvHmE',
    'https://link.amazon/B07YlY3f4',
    'https://link.amazon/B06TGOsmQ',
    'https://link.amazon/B0ia6KojP',
    'https://link.amazon/B08nFsQPl',
    'https://link.amazon/B051yGU6P',
    'https://link.amazon/B09A9SxnV',
    'https://link.amazon/B03hRUWxj',
    'https://link.amazon/B0i6lCwDx',
    'https://link.amazon/B0g6ZDrUl',
    'https://link.amazon/B0hKGk1dj',
    'https://link.amazon/B0iDQPHqY'
)
$urls | ForEach-Object {
    try {
        $response = Invoke-WebRequest -Uri $_ -Method Head -ErrorAction SilentlyContinue -MaximumRedirection 0
        $location = $response.Headers.Location
        Write-Output "$_ -> $location"
    } catch {
        Write-Output "$_ -> ERROR: $($_.Exception.Message)"
    }
}