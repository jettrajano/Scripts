Get-MgUserLicenseDetail -UserId "ajunges@neugebauer.com.br"

Connect-Graph -Scopes User.ReadWrite.All, Organization.Read.All

Install-Module Graph


Connect-MgGraph -Scopes "User.Read.All","Group.ReadWrite.All"

(Get-MsolUser -UserPrincipalName ajunges@neugebauer.com.br).Licenses[<LicenseIndexNumber>].ServiceStatus

(Get-MsolUser -UserPrincipalName ajunges@neugebauer.com.br).Licenses.ServiceStatus


(Get-MgUserLicenseDetail -UserId ajunges@neugebauer.com.br -Property ServicePlans).ServicePlans

$userUPN="ajunges@neugebauer.com.br"
$allLicenses = Get-MgUserLicenseDetail -UserId $userUPN -Property SkuPartNumber, ServicePlans
$allLicenses | ForEach-Object {
    Write-Host "License:" $_.SkuPartNumber
    $_.ServicePlans | ForEach-Object {$_}
}


(Get-MgUserLicenseDetail -UserId ajunges@neugebauer.com.br -Property ServicePlans)["PROJECT_P1"].ServicePlans

(Get-MgUserLicenseDetail -UserId belindan@litwareinc.com -Property ServicePlans).ServicePlans

(Get-MgUserLicenseDetail -UserId belindan@litwareinc.com -Property ServicePlans)[0].ServicePlans