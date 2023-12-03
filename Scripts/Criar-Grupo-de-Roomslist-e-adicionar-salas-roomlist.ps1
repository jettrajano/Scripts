## instalar e conectar ao ambiente da nuvem para gerenciar as listas de distribuição
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
Set-ExecutionPolicy RemoteSigned
Install-Module ExchangeOnlineManagement
Import-Module ExchangeOnlineManagement
Connect-ExchangeOnline

## Criar grupo de sala de reunião
New-DistributionGroup -Name "Nome do grupo aqui" -OrganizationalUnit "Nome da lista de salas" -RoomList

## Listar todas as salas de reunião
Get-distributiongroup -ResultSize unlimited -Filter "RecipientTypeDetails -eq 'Roomlist'"

## Adicionar uma nova sala a lista Salas
Add-DistributionGroupMember -Identity "Nome da lista de distrbuição aqui" -Member "Endereço de email da sala aqui"

## ## Listar todas as salas de reunião com detalhes de calendário e agendamentos
Get-Mailbox -ResultSize unlimited -Filter "RecipientTypeDetails -eq 'Roomlist'" | Get-CalendarProcessing | Format-List Identity,ScheduleOnlyDuringWorkHours,MaximumDurationInMinutes


## ## Listar todas as salas de reunião de um grupo com detalhes de calendário e agendamentos
Get-DistributionGroupMember -identity "DiplayName do grupo aqui" | Get-CalendarProcessing | Format-List Identity,ScheduleOnlyDuringWorkHours,MaximumDurationInMinutes
