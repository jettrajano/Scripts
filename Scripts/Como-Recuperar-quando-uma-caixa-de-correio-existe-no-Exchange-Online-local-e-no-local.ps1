## Cenário 1: Manter Exchange Online caixa de correio
## Esse cenário seria mais aplicável se a caixa de correio do usuário fosse migrada anteriormente para o Exchange Online e, de alguma forma, a caixa de correio antiga fosse reconectada ou uma nova caixa de correio fosse provisionada localmente. Outro cenário possível é quando uma licença do Exchange Online é atribuída prematuramente e uma nova caixa de correio somente na nuvem é criada enquanto o usuário já tem uma caixa de correio existente no Exchange local. Leia a observação importante no final da etapa 8.
## Para usar esse método, siga estas etapas:
## Abra o Shell de Gerenciamento do Exchange, salve as informações da caixa de correio local em um arquivo, como "Endereços SMTP", "DN herdado do Exchange", "Atributos do Exchange" e assim por diante.
## Defina o limite de enumeração do Formato do PowerShell como "ilimitado" para garantir que nenhum valor de atributo seja truncado. Por exemplo:

## No Exchange server Abra o Shell como Admin
$formatenumerationlimit = -1
Get-Mailbox "mailbox identity" | fl > mailboxinfo.txt

## Desconecte a caixa de correio local:
Disable-Mailbox "carlos.ferreira"

## Habilite o usuário local como uma caixa de correio remota:
Enable-RemoteMailbox "carlos.ferreira" -RemoteRoutingAddress "carlos.ferreira@pratidonaduzzi.mail.onmicrosoft.com"

### Restaure quaisquer endereços proxy personalizados e quaisquer outros Exchange Server atributos que foram removidos quando a caixa de correio foi desabilitada (Get-Mailboxcompare com o cmdlet da etapa 2).
## Adicione o LegacyExchangeDN valor da caixa de correio local anterior ao endereço proxy da nova caixa de correio remota como um endereço x500. Para fazer isso, execute o seguinte cmdlet:
## Observação: O valor do parâmetro LegacyExchangeDN pode ser encontrado no arquivo salvo na etapa 2.
Set-RemoteMailbox -Identity "carlos.ferreira" -EmailAddresses @{add="x500:/o=First Organization/ou=Exchange Administrative Group (FYDIBOHF23SPDLT)/cn=Recipients/cn=carlos.ferreira"}

## Colete os GUIDs das caixas de correio e do banco de dados:
## Para obter o GUID da caixa de correio desconectada, use ExchangeGUID o valor do parâmetro do arquivo salvo na etapa 2.
## Para obter o GUID do banco de dados local, use Database o valor do parâmetro do arquivo salvo na etapa 2 e execute o seguinte cmdlet:
Get-MailboxDatabase "BD_TI" | fl *GUID*
Get-Mailbox "carlos.ferreira" | fl *ExchangeGUID*

## Para obter o GUID da caixa de correio na nuvem, execute o seguinte cmdlet usando Exchange Online PowerShell:
##Exchange Online:
Import-Module ExchangeOnlineManagement
Connect-ExchangeOnline
Get-Mailbox "carlos.ferreira@pratidonaduzzi.com.br" | fl *ExchangeGUID*

###  https://learn.microsoft.com/pt-br/exchange/troubleshoot/user-and-shared-mailboxes/mailbox-exists-exo-onpremises
###
###FYDIBOHF23SPDLT)/cn=Recipients/cn=carlos.ferreira
###  Get-MailboxDatabase "BD_TI" | fl *GUID*
###  Guid : 860c20a4-dedb-4a48-bf53-d2b0804ef484
###  Set-RemoteMailbox "carlos.ferreira" -ExchangeGuid "faaad618-627c-463f-910c-d86f76d1cd03"
###  $cred = Get-Credential
###  New-MailboxRestoreRequest -RemoteHostName "mail.pratidonaduzzi.com" -RemoteCredential $cred -SourceStoreMailbox "faaad618-627c-463f-910c-d86f76d1cd03" -TargetMailbox "faaad618-627c-463f-910c-d86f76d1cd03" -RemoteDatabaseGuid "860c20a4-dedb-4a48-bf53-d2b0804ef484" -RemoteRestoreType DisconnectedMailbox
###
###
