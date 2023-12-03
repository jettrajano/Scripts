## Conectar ao Exchange Onlinemanagement
Connect-MsolService -Credential $credential
Import-Module ExchangeOnlineManagement
Connect-ExchangeOnline -ShowProgress $true

## Conectar a conta do usuário que precisa remover as entradas
## coletar os eventos de calendário da Conta
Get-EXOMailbox -Identity 'UPN' -RecipientTypeDetails SchedulingMailbox

## comando para remover as entrada de eventos
Remove-mailbox [BookingCalendarToDelete]

## Validar se o comando foi concluido tudo sucesso a lista deve ficar vazio
Get-EXOMailbox -RecipientTypeDetails SchedulingMailbox