ldifde -d “DistinguishedName of the user” -f “c:\temp\exporteduser.txt”## Definição remota
Set-ExecutionPolicy RemoteSigned
## ativa conexão sobre tls.12 
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
## Instala os modulos necessários caso não tenha.
Install-module AzureADPreview -Force
Install-Module MSOnline
Import-Module AzureAD
## Conecta aos modulos
Connect-AzureAD 
Connect-MsolService
## Comando para limpar o atributo do usuário sincronizado.
Get-MsolUser -UserPrincipalName fulano@mecur.com.br | Set-MsolUser -ImmutableId $null


 Set-AzureAdUser -ObjectId willian.fonseca@arqdigital.com.br -ImmutableId JtXnzadk/ESyKuAt27mJqA==


 Set-ADSyncScheduler -SyncCycleEnabled $true
 
Start-ADSyncSyncCycle -PolicyType Delta
import-module -name Msolservices

Get-MsolUser -UserPrincipalName 317496ee-974d-477f-ad7e-7e7dd5fcf0fe | Set-MsolUser -ImmutableId $null

$Filepath = $env:userprofile\desktop\file.csv
$csv = Import-Csv -Path $filepath
$immutableID=$null
 
Foreach($user in $csv)
{
Set-MsolUser -UserPrincipalName $user.UserPrincipalName -ImmutableID $immutableID
}