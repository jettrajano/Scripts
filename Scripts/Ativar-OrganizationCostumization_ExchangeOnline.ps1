#conecta ao modulo Exchange Online PowerShell
Import-Module ExchangeOnlineManagement
Connect-ExchangeOnline -ShowProgress $true
#Ativar Organization Customizations para poder configurar regras personalizadas de Anti-spam, phishing e mal-ware
Enable-OrganizationCustomization
Enable-OrganizationCustomization


Set-ExecutionPolicy Unrestricted

$LiveCred = Get-Credential
Import-Module -Name ExchangeOnlineManagement
Connect-ExchangeOnline -ConnectionUri https://ps.outlook.com/powershell/ -Credential $LiveCred
New-ManagementRoleAssignment -Role "ApplicationImpersonation" -User sou.cloud@forship.onmicrosoft.com