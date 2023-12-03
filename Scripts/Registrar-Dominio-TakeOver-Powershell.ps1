## Conjuto de comandos para importa e conectar ao serviço de Exchange Online rode os comandos import-module e conect-MsolService juntos (necessario às permissões Exchange Admin, Global Admin)
Import-Module MSOnline
Connect-MsolService

## Adicionar o novo dominio sem apastas
New-MsolDomain –Name "Digite aqui o domínio sem aspas"

## verificar se o domínio foi adicionado ao tenant
Get-MsolDomain 

## Gerar os registros TXT para serem adicionados a zona de DNS
Get-MsolDomainVerificationDns –DomainName "Digite aqui o domínio sem aspas" –Mode DnsTxtRecord

## Forçar o registro do domínio no tenant
Confirm-MsolDomain –DomainName "Digite aqui o domínio sem aspas" –ForceTakeover Force