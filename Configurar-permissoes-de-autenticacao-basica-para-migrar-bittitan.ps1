#Exchange Online
Connect-MsolService -Credential $credential
Import-Module ExchangeOnlineManagement
Connect-ExchangeOnline -ShowProgress $true

## Verificar a lista de politicas de permissões para o usuário que rodará a migração
Get-User -Identity sou.cloud@forship.onmicrosoft.com | fl *auth*
## Se retornar o valor da tabela em vazio rode o comando abaixo para criar uma nova politica
New-AuthenticationPolicy -Name "Enable Basic Auth for EWS"
## Defina a lista das politicas e permissões para a nova policita que criou no comando anterior
Set-AuthenticationPolicy -Identity "Enable Basic Auth for EWS" -AllowBasicAuthWebServices -AllowBasicAuthOutlookService -AllowBasicAuthAutodiscover
## Defina como padrão a politica criada e configurada nos comandos anteriores
Set-OrganizationConfig -DefaultAuthenticationPolicy "Enable Basic Auth for EWS"
## Verifique a lista de politicas atribuidas ao usuário
Get-OrganizationConfig | fl *defaultauth* | fl Oauth*
## Limpe o cache das chaves de autenticação anteriores
Set-User -Identity sou.cloud@forship.onmicrosoft.com -STSRefreshTokensValidFrom $([System.DateTime]::UtcNow)

## conceder permissões as caixas que irão migrar
Get-Mailbox -ResultSize Unlimited | Add-MailboxPermission -AccessRights FullAccess -User sou.cloud@forship.onmicrosoft.com













Set-User -Identity sou.cloud@gramcell.com.br -AuthenticationPolicy "Enable Basic Auth for EWS"

Set-OrganizationConfig -DefaultAuthenticationPolicy "Enable Basic Auth for EWS"