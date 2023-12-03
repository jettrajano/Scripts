## instalar e conectar ao ambiente da nuvem para gerenciar as listas de distribuição
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
Set-ExecutionPolicy RemoteSigned
Install-Module ExchangeOnlineManagement
Import-Module ExchangeOnlineManagement
Connect-ExchangeOnline

## Listar todas as Roomlist de salas de reunião
Get-distributiongroup -ResultSize unlimited -Filter "RecipientTypeDetails -eq 'Roomlist'"

## Adicionar uma nova sala a lista Salas
Add-DistributionGroupMember -Identity "Brooklin" -Member "Brooklin-Sala06@baruel.com.br"

## Listar todas as salas de reunião de RoomList
Get-DistributionGroupMember -Identity "Displayname da RoomList"