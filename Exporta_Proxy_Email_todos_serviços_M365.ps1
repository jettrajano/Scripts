##Conecta aos serviços do Microsoft 365
$credential = Get-Credential
Connect-MsolService -Credential $credential

#$exchangeSession = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri "https://outlook.office365.com/powershell-liveid/" -Credential $credential -Authentication "Basic" -AllowRedirection
##Import-PSSession $exchangeSession -DisableNameChecking
Connect-MsolService -Credential $credential
Import-Module ExchangeOnlineManagement
Connect-ExchangeOnline -ShowProgress $true


#Coleta detalhes de proxy address, e-mail Address dos usuários com caixa de email.
Get-MsolUser -all | Select-Object displayName, @{L = "ProxyAddresses"; E = { $_.ProxyAddresses -join ";"}},AlternateEmailAddresses, RecipientTypeDetails, mailNickName, Email, targetAddress, proxyAddresse|Export-Csv -Path C:\temp\MsolUser.csv -NoTypeInformation
Get-MsolGroup -all | Select-Object displayName, @{L = "ProxyAddresses"; E = { $_.ProxyAddresses -join ";"}},AlternateEmailAddresses, RecipientTypeDetails, mailNickName, Email, targetAddress, proxyAddresse|Export-Csv -Path C:\temp\MsolGroup.csv -NoTypeInformation
Get-MsolServicePrincipal -all | Select-Object displayName, @{L = "ProxyAddresses"; E = { $_.ProxyAddresses -join ";"}},AlternateEmailAddresses, RecipientTypeDetails, mailNickName, Email, targetAddress, proxyAddresse|Export-Csv -Path C:\temp\MsolServicePrincipal.csv -NoTypeInformation
Get-MsolContact -all | Select-Object displayName, @{L = "ProxyAddresses"; E = { $_.ProxyAddresses -join ";"}},AlternateEmailAddresses, RecipientTypeDetails, mailNickName, Email, targetAddress, proxyAddresse|Export-Csv -Path C:\temp\MsolContact.csv -NoTypeInformation
Get-MsolDevice -all | Select-Object displayName, @{L = "ProxyAddresses"; E = { $_.ProxyAddresses -join ";"}},AlternateEmailAddresses, RecipientTypeDetails, mailNickName, Email, targetAddress, proxyAddresse|Export-Csv -Path C:\temp\MsolDevice.csv -NoTypeInformation
