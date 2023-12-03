##Conectar ao SPO ONLINE
Connect-SPOService -Url https://m365t96172727-admin.sharepoint.com/
#Concete a conta de ADmin Global
Connect-IPPSSession -UserPrincipalName "admin@M365t96172727.onmicrosoft.com"
#Importar exchangeOnline
Import-Module ExchangeOnlineManagement
$UserCredential = Get-Credential
Connect-IPPSSession #-Credential $UserCredential
#Ativar AIP
Set-SPOTenant -EnableAIPIntegration $true
#Compliance Module
Execute-AzureAdLabelSync

set-SPOTenant -EnableSensitivityLabelforPDF $true