## Definição remota
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
Get-MsolUser -UserPrincipalName rafael.brito@pratidonaduzzi.com.br | Set-MsolUser -ImmutableId kx8tWS0z0EuUqqP6zNMQfg==

Set-AzureAdUser -ObjectId f001261e-3bcb-4c9c-98f0-c870fad77975 -ImmutableId kx8tWS0z0EuUqqP6zNMQfg==


Set-AzureAdUser -ObjectId de0f2098-0b9d-4ea2-8ced-70fe51af3212 -ImmutableId 22kx8tWS0z0EuUqqP6zNMQfg==


## Caso esteja utilizando um servidor ADFS, é necessário realizar uma etapa adicional, após alterar os usuários para nuvem
## você precisará alterar o domínio federado para o domínio padrão.

Convert-MsolDomainToStandard -DomainName dicasdeinfra.com.br -WhatIf
Convert-MsolDomainToStandard -DomainName  dicasdeinfra.com.br -Confirm