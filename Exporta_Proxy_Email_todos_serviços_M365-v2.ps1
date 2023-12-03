#Exchange Online
Connect-MsolService -Credential $credential
Import-Module ExchangeOnlineManagement
Connect-ExchangeOnline -ShowProgress $true
## Exportar endereços SMTP Online de todos usuários.
Get-Mailbox -ResultSize Unlimited |Select-Object DisplayName,PrimarySmtpAddress, @{Name=“EmailAddresses”;Expression={$_.EmailAddresses |Where-Object {$_.PrefixString -ceq “smtp”} | ForEach-Object {$_.SmtpAddress}}} | export-CSV c:\temp\exportsmtp-PortalSolar.csv -NoTypeInformation