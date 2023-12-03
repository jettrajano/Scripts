Set-TransportConfig -SmtpClientAuthenticationDisabled:$false

New-AuthenticationPolicy BLOCK-BasicAuth

New-AuthenticationPolicy ALLOW-BasicAuth

Set-OrganizationConfig -DefaultAuthenticationPolicy BLOCK-BasicAuth

Set-AuthenticationPolicy ALLOW-BasicAuth -AllowBasicAuthSmtp:$true

Get-User suporteveye@virtueyes.com.br | Set-User -AuthenticationPolicy ALLOW-BasicAuth

set-casmailbox boleto@virtueyes.com.br -SmtpClientAuthenticationDisabled:$false