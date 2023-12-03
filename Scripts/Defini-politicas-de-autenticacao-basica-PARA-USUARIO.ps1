Connect-MsolService -Credential $credential
Import-Module ExchangeOnlineManagement
Connect-ExchangeOnline -ShowProgress $true

## Veriricar qual as permissões de smtpclienteautentication
Get-CASMailbox -Identity boleto@virtueyes.com.br | Format-List SmtpClientAuthenticationDisabled
Get-CASMailbox -Identity suporte@virtueyes.com.br | Format-List SmtpClientAuthenticationDisabled
Get-CASMailbox -Identity suporteveye@virtueyes.com.br  | Format-List SmtpClientAuthenticationDisabled



Set-CASMailbox -Identity boleto@virtueyes.com.br -SmtpClientAuthenticationDisabled $false
Set-CASMailbox -Identity suporte@virtueyes.com.br -SmtpClientAuthenticationDisabled $false
Set-CASMailbox -Identity suporteveye@virtueyes.com.br -SmtpClientAuthenticationDisabled $false

Set-CASMailbox -Identity <EmailAddress> -SmtpClientAuthenticationDisabled $false


Get-TransportConfig | select AllowLegacyTLSClients

Get-TransportConfig | Format-List SmtpClientAuthenticationDisabled 

 Set-TransportConfig -SmtpClientAuthenticationDisabled $false


 Get-User boleto@virtueyes.com.br | Set-User -AuthenticationPolicy ALLOW-BasicAuth

 Set-TransportConfig -AllowLegacyTLSClients $true


 Connect-AzureAD -Credential $credential


 Get-TransportConfig | Format-List SmtpClientAuthenticationDisabled