Salas@construtoraplaneta.onmicrosoft.com

Salas                  Salas       Universal Salas@construtoraplaneta.onmicrosoft.com

## Para exibir as salas disponíveis, selecione uma lista de salas na caixa Mostrar uma lista de salas. Se uma lista de salas estiver selecionada e a sala ainda não estiver visível, verifique se a sala está visível na GAL.

## Conectar ao Exchange Online
Connect-MsolService -Credential $credential
Import-Module ExchangeOnlineManagement
Connect-ExchangeOnline -ShowProgress $true

## Execute o seguinte comando para criar uma lista de salas:
New-DistributionGroup "Roomlist" -RoomList -Members $Members

## Execute o seguinte comando para adicionar salas existentes à lista de salas:
Add-DistributionGroupMember "Lista-de-salas" -Member sala-01@construtoraplaneta.com.br

## Para verificar se você alterou com êxito as propriedades da caixa de correio de sala, faça o seguinte:
Get-Mailbox -ResultSize unlimited -Filter "RecipientTypeDetails -eq 'RoomMailbox'" | fl * #| Get-CalendarProcessing | Format-List Identity,ScheduleOnlyDuringWorkHours,MaximumDurationInMinutes

Get-OrganizationConfig | Select-Object Ews*

Set-OrganizationConfig -EwsApplicationAccessPolicy EnforceAllowList -EwsAllowList @{Add="*SchedulingService*"}

Get-CasMailbox sala-01@construtoraplaneta.com.br | Select-Object Ews*

Set-CASMailbox sala-01@construtoraplaneta.com.br -EwsApplicationAccessPolicy EnforceAllowList -EwsAllowList @{Add="*SchedulingService*"}

Set-OrganizationConfig -EwsApplicationAccessPolicy EnforceAllowList -EwsAllowList @{Add="MicrosoftNinja/*","*Teams/*","SkypeSpaces/*"}


Get-OrganizationConfig | Select-Object Ews*


Remove-DistributionGroupMember -Identity Salas -Member Fiat UNO

 Get-DistributionGroupMember Salas
  Get-DistributionGroupMember SalasReuniao@construtoraplaneta.onmicrosoft.com


  get-distributiongroup -recipentetypedetails roomlist

  Get-Mailbox -RecipientTypeDetails RoomMailbox

  Get-DistributionGroup -RecipientTypeDetails RoomList


  New-Mailbox -Alias Teste1Sala -Name "Salateste1" -DisplayName "Salateste1 - Teste1Sala" -Room
Set-Mailbox -Identity "Salateste1" -Office "Salateste1"

# New Roomlist Distribution Group
New-DistributionGroup -Name "TesteGrupoSala" –PrimarySmtpAddress "TesteGrupoSala@construtoraplaneta.onmicrosoft.com" –RoomList

Add-DistributionGroupMember -Identity "TesteGrupoSala" -Member Salateste1