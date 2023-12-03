## comandos para conectar no tenant
Connect-MsolService -Credential $credential
## comando para conectar no Exhange
Connect-ExchangeOnline -ShowProgress $true
## comando para definir o idioma “Language” e fuso horário “TimeZone” para todos os usuários do Office 365
## 1046 corresponde ao idioma portuguese brazil e da gmt time zone 1046

Get-Mailbox -ResultSize unlimited  | Get-MailboxRegionalConfiguration | Set-MailboxRegionalConfiguration -Language pt-br -TimeZone "E. South America Standard Time"
## se não funcionar alterar para “E. South America Standard Time”
