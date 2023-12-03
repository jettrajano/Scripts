$allSKUs = Get-MgSubscribedSku -Property SkuPartNumber, ServicePlans 
$allSKUs | ForEach-Object {
    Write-Host "Service Plan:" $_.SkuPartNumber
    $_.ServicePlans | ForEach-Object {$_}
}