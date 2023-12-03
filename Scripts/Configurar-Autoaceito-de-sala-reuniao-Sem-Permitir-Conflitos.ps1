#Conectar ao Exchange Online
Connect-MsolService -Credential $credential
Import-Module ExchangeOnlineManagement
Connect-ExchangeOnline -ShowProgress $true

##Coletar status da configuração atual de agendamento da sala substituir tanto o texto quanto os simbolos de Mior que e Menor que pelo endereço de email da sala
Get-calendarprocessing sala2@jeracapital.com.br | fl *policy

Get-CalendarProcessing -Identity "sala2@jeracapital.com.br" | Set-CalendarProcessing -AllRequestOutOfPolicy $False

##Definir como o parametro de permitir conflito com falso substituir tanto o texto quanto os simbolos de Maior que e Menor que pelo endereço de email da sala
Get-CalendarProcessing -Identity sala2@jeracapital.com.br | set-CalendarProcessing -AllRequestOutOfPolicy $false

## Definir as politicas de uma sala de reunião para auto aceitar, não permitir conflitos e processar automaticamento os convites recebidos. 
## Substituir tanto o texto quanto os simbolos de Mior que e Menor que pelo endereço de email da sala com a configuração para foram da organização
Set-CalendarProcessing sala1@jeracapital.com.br  -AutomateProcessing AutoAccept -ConflictPercentageAllowed 0 -maximumConflictInstances 0 -AllRequestOutOfPolicy $false -ProcessExternalMeetingMessages $true