﻿##Conectar ao processo de criação dos grupos
#Connect-MsolService -Credential $credential
#Import-Module ExchangeOnlineManagement
#Connect-ExchangeOnline -ShowProgress $true
## Coletar o nome completo da licença
#Get-MsolAccountSku

Import-Module AzureADPreview
Connect-AzureAD

#Importa lista do diretório local
$pahtlista = "C:\Temp\UPNObjguid.csv"
#Le a lista de grupos
$lista = Import-csv $pahtlista #-Delimiter ","
#Parametro para contar o número de grupos
$cont = 1
#Looping para criar os grupos
foreach($iten in $lista){
#criar as váriaveis com base na lista importada nos comandos anteriores
$UPN = $iten.UPN
$objguid = $iten.objguid
#Escreve na tela do PS os detalhes dos grupos que estão sendo criados
Write-Host($cont, "-", $UPN, $objguid)
#Conta parametro para mostrar os grupos que estão na lista de criação
$cont ++
#Comando de criação de grupos de seurança
Set-AzureAdUser -ObjectId $UPN -ImmutableId $objguid
#Set-MsolUserLicense -UserPrincipalName $UPN -AddLicenses $lic
}

UPNObjguid