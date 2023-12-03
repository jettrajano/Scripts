#Exchange Online
Connect-MsolService -Credential $credential
Import-Module ExchangeOnlineManagement
Connect-ExchangeOnline -ShowProgress $true
#Importa lista do diretório local
$pahtlista = "C:\Temp\distlistgroup.csv"
#Le a lista de grupos
$lista = Import-csv $pahtlista #-Delimiter ","
#Parametro para contar o número de grupos
$cont = 1
#Looping para criar os grupos
foreach($iten in $lista){
#criar as váriaveis com base na lista importada nos comandos anteriores
$gpName = $iten.DisplayName
$gpdesc = $iten.Description
$gpmail = $iten.PrimarySmtpAddress
#$gmember = $iten.Members
#Escreve na tela do PS os detalhes dos grupos que estão sendo criados
Write-Host($cont, "-", $gpName)
#Conta parametro para mostrar os grupos que estão na lista de criação
$cont ++
#Comando de criação de grupos de seurança
New-DistributionGroup  -Description $gpdesc -DisplayName $gpName -PrimarySmtpAddress $gpmail -BypassNestedModerationEnabled $false -IgnoreNamingPolicy $true -Type Distribution   #-Members $gmember
}
#Comando para verificar os grupos
Get-DistributionGroup
