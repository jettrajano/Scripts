## instalar e conectar ao ambiente da nuvem para gerenciar as listas de distribuição
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
Set-ExecutionPolicy RemoteSigned
Install-Module ExchangeOnlineManagement
Import-Module ExchangeOnlineManagement
Connect-ExchangeOnline

## Listar todas as salas de reunião
Get-distributiongroup -ResultSize unlimited -Filter "RecipientTypeDetails -eq 'Roomlist'"

## Adicionar uma nova sala a lista Salas
Add-DistributionGroupMember -Identity "Salas" -Member "Digitar o endereço de email da sala sem as apas"


$ou@#@Admin05

https://answers.microsoft.com/en-us/msoffice/forum/all/print-to-pdf-all-of-a-sudden-sensitivity-labels/d70a6360-4981-4f1b-97b4-8c13c277c528?from=supportcentralbcqr


https://insider.microsoft365.com/zh-cn/blog/apply-sensitivity-labels-to-pdfs-created-with-office-apps

https://learn.microsoft.com/en-us/microsoft-365/compliance/sensitivity-labels-sharepoint-onedrive-files?view=o365-worldwide#requirements