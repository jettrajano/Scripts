﻿## Conjuto de comandos para importa e conectar ao serviço de Exchange Online rode os comandos import-module e conect-Exchange juntos (necessario às permissões Exchange Admin, Global Admin)
Import-Module ExchangeOnlineManagement
Connect-ExchangeOnline -ShowProgress $true

## Comando para realizar o backup de toda a lista de SafeSenders diretamente da caixa dos usuários do tenant importante salvar a lista atual dos usuários para um eventual problema
Get-Mailbox -ResultSize Unlimited | Get-MailboxJunkEmailConfiguration | Export-CSV c:\temp\ListaSafeSendeers-2022.CSV –NoTypeInformation -Encoding utf8


## Após realizar o exporte da lista de SafeSenders dos usuários, agora pode adicionar a nova lista.
## Usando o comando abaixo para realizar essa inclusão, o tempo de execução do script dependerá da quantidade de usuários e quantos domínios ou endereços de e-email serão adicionados a lista de SafeSenders de cada usuário.

## Comando para fazer adição de domínio/emails na lista SafeSenders de um usuário especifico no tenant. 
## Os domínios e e-mails devem ser adicionados entre as chaves após o @{ estando entre aspas dubplas ""} coloque sempre os novos domínios/emails no inicio após o Add=
Set-MailboxJunkEmailConfiguration -Identity william.nogueira@zilor.com.br -TrustedSendersAndDomains @{Add="mail-seguro.com","microdrive@mail-sec.com","mail-sec.com", "eskive.com","mkt-mail.com","inviteseguro.com","redirectaccess.com","notificationatemail.com","notificacaosegura.com","accessnotification.com"}

## Comando para fazer adição de domínio/emails na lista SafeSenders de todos os usuário dos tenant. 
## Os domínios e e-mails devem ser adicionados entre as chaves após o @{ estando entre aspas dubplas ""}  coloque sempre os novos domínios/emails no inicio após o Add=
Get-Mailbox -ResultSize Unlimited | Set-MailboxJunkEmailConfiguration -TrustedSendersAndDomains @{Add="mail-seguro.com","microdrive@mail-sec.com","mail-sec.com", "eskive.com","mkt-mail.com","inviteseguro.com","redirectaccess.com","notificationatemail.com","notificacaosegura.com","accessnotification.com"}