
if ($PSDebugContext) {
    Write-Output "No debugging allowed!"
    exit
}


$encoded = "JGRlY29kZWQgPSBbU3lzdGVtLkNvbnZlcnRdOjpGcm9tQmFzZTY0U3RyaW5nKCdTMEZNUVUxN05EVmtNak5qTVdZMk56ZzVZbUZrWXpFeU16UTFOamM0T1RBeE1qTTBOVFo5RFFvPScpDQokZmxhZyA9IFtTeXN0ZW0uVGV4dC5FbmNvZGluZ106OlVURjguR2V0U3RyaW5nKCRkZWNvZGVkKQ0KDQojIE9ubHkgc2hvdyBmbGFnIGlmIHNwZWNpZmljIGVudmlyb25tZW50IHZhcmlhYmxlIGlzIHNldA0KaWYgKCRlbnY6TUFHSUNfS0VZIC1lcSAnU3VwM3JTM2NyM3QhJykgew0KICAgIFdyaXRlLU91dHB1dCAkZmxhZw0KfSBlbHNlIHsNCiAgICBXcml0ZS1PdXRwdXQgIk5pY2UgdHJ5ISBCdXQgeW91IG5lZWQgdGhlIG1hZ2ljIGtleSEiDQp9"
$bytes = [Convert]::FromBase64String($encoded)
$decodedScript = [System.Text.Encoding]::UTF8.GetString($bytes)


$argumentList = "-NoProfile", "-NonInteractive", "-Command", $decodedScript


$startInfo = New-Object System.Diagnostics.ProcessStartInfo
$startInfo.FileName = "powershell.exe"
$startInfo.Arguments = $argumentList -join ' '
$startInfo.RedirectStandardOutput = $true
$startInfo.RedirectStandardError = $true
$startInfo.UseShellExecute = $false
$startInfo.CreateNoWindow = $true

$process = New-Object System.Diagnostics.Process
$process.StartInfo = $startInfo
$process.Start() | Out-Null
$output = $process.StandardOutput.ReadToEnd()
$process.WaitForExit()

Write-Output $output