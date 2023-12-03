## Conjuto de comandos para importa e conectar ao serviço de Exchange Online rode os comandos import-module e conect-Exchange juntos (necessario às permissões Exchange Admin, Global Admin)
Import-Module ExchangeOnlineManagement
Connect-ExchangeOnline -ShowProgress $true

## Coletar todos os usuários do tenant com caixa de emails ativas e adicionar a funão fum acessess para um usuário  
Get-Mailbox -ResultSize Unlimited | Add-MailboxPermission -AccessRights FullAccess -AutoMapping $false -Confirm:$false -User "UPN do usuário que terar o acesso coloar sem as aspas"