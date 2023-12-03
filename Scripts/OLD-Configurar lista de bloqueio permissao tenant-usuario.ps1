Import-Module ExchangeOnlineManagement
Connect-ExchangeOnline

Get-Mailbox -ResultSize Unlimited | Set-MailboxJunkEmailConfiguration -TrustedSendersAndDomains @{Add="mail-seguro.com","microdrive@mail-sec.com","mail-sec.com", "eskive.com","mkt-mail.com","inviteseguro.com","redirectaccess.com","notificationatemail.com","notificacaosegura.com","accessnotification.com"}

Set-MailboxJunkEmailConfiguration -Identity william.nogueira@zilor.com.br -TrustedSendersAndDomains @{Add="mail-seguro.com","microdrive@mail-sec.com","mail-sec.com", "eskive.com","mkt-mail.com","inviteseguro.com","redirectaccess.com","notificationatemail.com","notificacaosegura.com","accessnotification.com"}

Set-MailboxJunkEmailConfiguration -Identity silva_rv@zilor.com.br -TrustedSendersAndDomains @{Add="mail-seguro.com","microdrive@mail-sec.com","mail-sec.com", "eskive.com","mkt-mail.com","inviteseguro.com","redirectaccess.com","notificationatemail.com","notificacaosegura.com","accessnotification.com"}

Set-MailboxJunkEmailConfiguration -Identity berbone_aj@zilor.com.br -TrustedSendersAndDomains @{Add="mail-seguro.com","microdrive@mail-sec.com","mail-sec.com", "eskive.com","mkt-mail.com","inviteseguro.com","redirectaccess.com","notificationatemail.com","notificacaosegura.com","accessnotification.com"}