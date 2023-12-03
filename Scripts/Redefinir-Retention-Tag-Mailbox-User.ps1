
## Conectar ao Exchange Onlinemanagement
Connect-MsolService -Credential $credential
Import-Module ExchangeOnlineManagement
Connect-ExchangeOnline -ShowProgress $true

## Listar as retentiontags da mailbox do usuário.
Get-RetentionPolicytag -Mailbox nfe@suspentech.com.br | FT Name,RetentionAction, Type, agelimitforRetention

## Limpa as retentiontas e liberar para redefinição de retenção
Set-Mailbox 'nfe@suspentech.com.br' -RetentionHoldEnabled $false

## Redefinir a mailbox para o padrão de retentiontag
Start-ManagedFolderAssistant 'nfe@suspentech.com.br'