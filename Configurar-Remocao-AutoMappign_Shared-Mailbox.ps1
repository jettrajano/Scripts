#Conectar ao modulo do EXO 
Import-Module ExchangeOnlineManagement
Connect-ExchangeOnline
#MailboxIdentity é o nome, alias ou endereço de email da caixa de correio da qual as permissões estão sendo removidas.
##UserIdentity é o nome, alias ou endereço de email do usuário da caixa de correio que está perdendo as permissões na caixa de correio.
#comando para remover o fullaccess da Shared mailbox 
Remove-MailboxPermission -Identity <MailboxIdentity> -User <UserIdentity> -AccessRights FullAccess -Confirm:$false
#MailboxIdentity especifica o nome, alias ou endereço de email da caixa de correio onde as permissões estão sendo adicionadas.
##UserIdentity especifica o nome, alias ou endereço de email do usuário da caixa de correio que está recebendo as permissões na caixa de correio.
#comando para adicionar novamente a permissão fullacess mas com automapping desativado
Add-MailboxPermission -Identity "Endereço de email da shared mailbox" -User "Endereço de email do usuário" -AccessRights FullAccess -AutoMapping $false -Confirm:$false