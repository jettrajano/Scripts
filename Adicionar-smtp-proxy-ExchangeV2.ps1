
Connect-MsolService -Credential $credential
Import-Module ExchangeOnlineManagement
Connect-ExchangeOnline -ShowProgress $true
Import-CSV "C:\temp\smtp.csv" | ForEach {Set-Mailbox $_.Mailbox -EmailAddresses @{add=$_.NewEmailAddress}}

Get-Mailbox irodrigues@ms.sim.digital | Format-List EmailAddresses

Set-Mailbox irodrigues@ms.sim.digital -EmailAddresses @{add="irodrigues@ms.sim.digital","rodrigues@simtelecom.com.br"}