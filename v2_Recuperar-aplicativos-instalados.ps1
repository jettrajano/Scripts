# Returns all MDM applications in the Intune Service
$softwareName = "AnyDesk"
$installedSoftware = Get-WmiObject -Class Win32_Product | Where-Object { $_.Name -match $softwareName }

if ($installedSoftware) {
    Write-Output "$softwareName está instalado."
} else {
    Write-Output "$softwareName não está instalado."
}
