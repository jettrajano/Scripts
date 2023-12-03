## Conjuto de comandos para importa e conectar ao serviço de Exchange Online rode os comandos import-module e conect-Exchange juntos (necessario às permissões Exchange Admin, Global Admin)
Import-Module ExchangeOnlineManagement
Connect-ExchangeOnline -ShowProgress $true

## ativar a costumização do tenant para permitir a configuração de uma nova política
Enable-OrganizationCustomization

## Criar nova política e atribuir a um usuário
New-ManagementRoleAssignment -Role "ApplicationImpersonation" -User "soucloud@sindario.onmicrosoft.com"


Get-Mailbox -ResultSize unlimited -Filter {(RecipientTypeDetails -eq 'UserMailbox') -and (Alias -ne 'Admin')} | Add-MailboxPermission -User soucloud@sindario.onmicrosoft.com -AccessRights fullaccess -InheritanceType all