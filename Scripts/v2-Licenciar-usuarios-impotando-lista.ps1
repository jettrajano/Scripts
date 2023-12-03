	
$user = Get-MsolUser -UserPrincipalName ChristieC@MSDx155310.OnMicrosoft.com
$user.Licenses
$user.Licenses.ServiceStatus

$user.Licenses.ServiceStatus | Where-Object -Property ProvisioningStatus -EQ 'Disabled'


2
3
4
5
$user = Get-MsolUser -UserPrincipalName ChristieC@MSDx155310.OnMicrosoft.com
$licenseObject = New-MsolLicenseOptions -AccountSkuId MSDx155310:SPE_E5 -DisabledPlans "ENTERPRISEPACKPLUS"#"EXCHANGE_S_ENTERPRISE","THREAT_INTELLIGENCE"#,"EXCHANGE_ANALYTICS"
Set-MsolUserLicense -UserPrincipalName ChristieC@MSDx155310.OnMicrosoft.com -LicenseOptions $licenseObject
(Get-MsolUser -UserPrincipalName ChristieC@MSDx155310.OnMicrosoft.com).Licenses.ServiceStatus

$user = Get-MsolUser -UserPrincipalName ChristieC@MSDx155310.OnMicrosoft.com

$licenseObject = New-MsolLicenseOptions -AccountSkuId MSDx155310:SPE_E5 -DisabledPlans EXCHANGE_S_ENTERPRISE
Set-MsolUserLicense -UserPrincipalName "ChristieC@MSDx155310.OnMicrosoft.com" -LicenseOptions $licenseObject

(Get-MsolUser -UserPrincipalName "ChristieC@MSDx155310.OnMicrosoft.com").Licenses.ServiceStatus