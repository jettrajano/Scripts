#Exchange Online
Connect-MsolService -Credential $credential
Import-Module ExchangeOnlineManagement
Connect-ExchangeOnline -ShowProgress $true

## Cria um Endpoint de migração IMAP
New-MigrationEndpoint -IMAP -Name IMAPEndpoint -RemoteServer imap-mail.outlook.com -Port 993 -Security SSL -MaxConcurrentMigrations 50 -MaxConcurrentIncrementalSyncs 25
## Valida se o Endpoint foi criado.
Get-MigrationEndpoint IMAPEndpoint | Format-List EndpointType,RemoteServer,Port,Security,Max*
##Criar um lote de migração importando CSV
New-MigrationBatch -Name IMAPBatch1 -SourceEndpoint IMAPEndpoint -CSVData ([System.IO.File]::ReadAllBytes("C:\Temp\Migracao-IMap-test1-Tamara.csv")) -AutoStart
## Valida se o importe foi feito com sucesso
Get-MigrationBatch -Identity IMAPBatch1 | Format-List
## Pega o status do lote de migração
Get-MigrationBatch -Identity IMAPBatch1 | Format-List Status