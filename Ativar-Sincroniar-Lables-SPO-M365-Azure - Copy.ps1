##Conectar ao SPO ONLINE
Connect-SPOService -Url https://ENDEREÇO-SPO-admin.sharepoint.com
#Concete a conta de ADmin Global
Connect-IPPSSession -UserPrincipalName "Colocar UPN do Global Admin"
#Importar exchangeOnline
Import-Module ExchangeOnlineManagement
$UserCredential = Get-Credential
Connect-IPPSSession -Credential $UserCredential
#Ativar AIP
Set-SPOTenant -EnableAIPIntegration $true
#Compliance Module
Execute-AzureAdLabelSync

