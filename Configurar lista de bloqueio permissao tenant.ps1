#Conectar aos modulos Exchange
Import-Module ExchangeOnlineManagement
Connect-ExchangeOnline

#Listar domínio permitidos ou bloqueado
Get-TenantAllowBlockListSpoofItems | Format-Table SpoofedUser,SendingInfrastructure,SpoofType,Action,Identity


# Permitir por domíno
New-TenantAllowBlockListSpoofItems -SpoofedUser "*.pipefy.com/*" -SpoofType External -Action Allow

## Permitir lista
$ list = ( Get-ContentFilterConfig ) .BypassedSenderDomains

$ list.add ( "domain1.com" )

$ list.add ( "domain2.com" )

$ list.add ( "domain3.com" )

Set-ContentFilterConfig -BypassedSenderDomains $ list


#bloquer por domínio
Set-TenantAllowBlockListSpoofItems -Identity Default -Action Block -Ids "*.pipefy.com/*"

# Bloquear por lista
$ list = ( Get-ContentFilterConfig ) .BlockSenderDomains

$ list.add ( "domain1.com" )

$ list.add ( "domain2.com" )

$ list.add ( "domain3.com" )

Set-ContentFilterConfig -BlockSenderDomains $ list