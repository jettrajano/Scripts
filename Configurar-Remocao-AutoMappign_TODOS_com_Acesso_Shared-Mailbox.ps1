#Conecta ao modulo do EXO Online
Import-Module ExchangeOnlineManagement
Connect-ExchangeOnline
#Pega Shared mailbox e lista quem tem fullaccess para remover o automapping
$FixAutoMapping = Get-MailboxPermission "endereço de email da Shared mailbox" |where {$_.AccessRights -eq "FullAccess" -and $_.IsInherited -eq $false}
#Remove o fullaccess da lista de usuários com acesso a shared mailbox
$FixAutoMapping | Remove-MailboxPermission
#Adicionar usuários listados no primeiro comando com fullaccess, mas com a função AUTOMAPPING desativada
$FixAutoMapping | ForEach {
Add-MailboxPermission -Identity $_.Identity -User $_.User -AccessRights:FullAccess -AutoMapping $false
}