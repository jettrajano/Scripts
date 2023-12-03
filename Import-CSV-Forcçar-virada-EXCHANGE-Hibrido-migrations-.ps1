set-MigrationUser -Identity renata.oliveira@bib.com.br -ApproveSkippedItems -CompleteAfter "02/15/2023 08:28 pm"
get-MigrationUser -Identity renata.oliveira@bib.com.br #-ApproveSkippedItems -CompleteAfter "02/15/2023 08:14 pm"
set-MigrationUser -Identity renata.oliveira@bib.com.br -CompleteAfter "02/15/2023 08:29 pm"


##Conectar ao processo de criação dos grupos
Connect-MsolService -Credential $credential
Import-Module ExchangeOnlineManagement
Connect-ExchangeOnline -ShowProgress $true
## Coletar o nome completo da licença
#Get-MsolAccountSku
#Importa lista do diretório local
$pahtlista = "C:\Temp\setmig.csv"
#Le a lista de grupos
$lista = Import-csv $pahtlista #-Delimiter ","
#Parametro para contar o número de grupos
$cont = 1
#Looping para criar os grupos
foreach($iten in $lista){
#criar as váriaveis com base na lista importada nos comandos anteriores
$UPN = $iten.Identity
#$lic = $iten.sku
#Escreve na tela do PS os detalhes dos grupos que estão sendo criados
Write-Host($cont, "-", $UPN)
#Conta parametro para mostrar os grupos que estão na lista de criação
$cont ++
#Comando de criação de grupos de seurança
#Set-MigrationUser -Identity $UPN -ApproveSkippedItems -CompleteAfter "02/16/2023 08:05 pm"
get-MigrationUser -Identity $UPN
}

set-MigrationUser -Identity joel.araujo@bib.com.br -ApproveSkippedItems -CompleteAfter "02/15/2023 09:32 pm"

set-MigrationUser -Identity renata.oliveira@bib.com.br -ApproveSkippedItems -CompleteAfter "02/15/2023 09:32 pm"

set-MigrationUser -Identity yan.assis@bib.com.br -ApproveSkippedItems -CompleteAfter "02/15/2023 09:32 pm"


get-MigrationUser -Identity joel.araujo@bib.com.br #-ApproveSkippedItems -CompleteAfter "02/15/2023 08:28 pm"

get-MigrationUser -Identity renata.oliveira@bib.com.br #-ApproveSkippedItems -CompleteAfter "02/15/2023 08:28 pm"

get-MigrationUser -Identity yan.assis@bib.com.br #-ApproveSkippedItems -CompleteAfter "02/15/2023 08:28 pm"


sou.cloud@bancoindustrial.com.br
Larissaaline@2013