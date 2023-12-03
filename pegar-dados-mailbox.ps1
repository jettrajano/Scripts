Connect-MsolService -Credential $credential
Import-Module ExchangeOnlineManagement
Connect-ExchangeOnline -ShowProgress $true


Get-MailboxFolderStatistics kluz@aisin.com.br

Get-EXOMailboxFolderStatistics kluz@aisin.com.br | fl *


Get-EXOMailbox  kluz@aisin.com.br
Get-EXOCASMailbox    kluz@aisin.com.br | fl *

Get-EXOMailbox -Identity kluz@aisin.com.br -ResultSize 10

Get-ExoMailboxStatistics -Identity kluz@aisin.com.br |select DisplayName,TotalItemSize,*quota* | fl *

Get-Mailbox -Identity kluz@aisin.com.br | select *quota*

Get-MailboxFolder -Identity kluz@aisin.com.br #-GetChildren