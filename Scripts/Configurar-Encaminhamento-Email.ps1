## Autentica no ambiente:
$Creds = Get-Credential
Connect-MsolService –Credential $Creds
$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://outlook.office365.com/powerShell-liveID?serializationLevel=Full -Credential $Creds -Authentication Basic -AllowRedirection
Import-PSSession $Session

## Caso autenticação falhe use a seguinte
#Conectar ao modulo do EXO 
Import-Module ExchangeOnlineManagement
Connect-ExchangeOnline

## Define o encaminhamento 1 para 1 sem manter cópia na origem
Set -Mailbox emailusuarioOrigem@dominio.com.br -ForwardingAddress emailusuarioDestino@dominio.com.br

## Define o encimainhamento 1 para 1 Os e-mails e emailusuárioOrigem serão encaminhados a emailusuarioDestino sem copia para Valéria com $false no fim
Set -Mailbox emailusuarioOrigem@dominio.com.br  -ForwardingAddress emailusuarioDestino@dominio.com.br $False

## Define o encaminhamento 1 para 1 como uma copia para o destinatário.
Set -Mailbox emailusuarioOrigem@dominio.com.br -ForwardingsmtpAddress emailusuarioDestino@dominio.com.br -DeliverToMailboxAndForward $False

## Remover regra:
Set -Mailbox emailusuarioOrigem@dominio.com.br -ForwardingAddress $Null


## Enviar copias para contatos externos é preciso criar um contato externo antes.
## Cria o contato e define endereço de email destino
New-MailContact -Name “Usuário Destino”
   -ExternalEmailAddress emailusuarioDestino@dominio.com.br
## Define função
Set -MailContact “Usuário Destino” -emailaddresses SMTP : emailusuarioOrigem@dominio.com.br, emailusuarioDestino@dominio.com.br

## Remover regra:
Set -Mailbox emailusuarioOrigem@dominio.com.br -ForwardingAddress $Null