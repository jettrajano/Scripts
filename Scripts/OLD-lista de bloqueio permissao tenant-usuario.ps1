Import-Module ExchangeOnlineManagement
Connect-ExchangeOnline -ShowProgress $tru
Get-MailboxJunkEmailConfiguration -Identity william.nogueira@zilor.com.br | fl


#Set-MailboxJunkEmailConfiguration -Identity william.nogueira@zilor.com.br -TrustedSendersAndDomains "cloudappsecurity.com","eskive.com","mkt-mail.com","inviteseguro.com","redirectaccess.com","notificationatemail.com","notificacaosegura.com"

Get-Mailbox -ResultSize Unlimited | Get-MailboxJunkEmailConfiguration | Export-Csv -Path "C:\temp\listIP.csv" -NoTypeInformation -Append

Get-Mailbox -ResultSize Unlimited | Get-MailboxJunkEmailConfiguration | Export-CSV c:\temp\ListaSafeSendeers-2022.CSV –NoTypeInformation -Encoding utf8