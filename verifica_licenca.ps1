## Conecta com Azure Active Directory for PS e mostra os domínios
$credential = Get-Credential
Connect-MsolService -Credential $credential
Get-MsolDomain

## Conecta com o Exchange Online e mostra os domínios
$exchangeSession = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri "https://outlook.office365.com/powershell-liveid/" (https://outlook.office365.com/powershell-liveid/%27) -Credential $credential -Authentication "Basic" -AllowRedirection
Import-PSSession $exchangeSession -DisableNameChecking
Get-AcceptedDomain

## Mostra propriedades do usuário informado pelo UPN
Get-MsolUser -UserPrincipalName paulo_malagueta@praxair.com | Select-Object UserPrincipalName, DisplayName, Licenses, LastDirSyncTime, Department, UsageLocation, AlternateEmailAddresses
Get-MsolUser -UserPrincipalName Osmel_Colmenares@praxair.com | Select-Object UserPrincipalName, DisplayName, Licenses, LastDirSyncTime, Department, UsageLocation, AlternateEmailAddresses
Get-MsolUser -UserPrincipalName Yojana_Medina@praxair.com | Select-Object UserPrincipalName, DisplayName, Licenses, LastDirSyncTime, Department, UsageLocation, AlternateEmailAddresses
Get-MsolUser -UserPrincipalName magdalena_azcurra@praxair.com | Select-Object UserPrincipalName, DisplayName, Licenses, LastDirSyncTime, Department, UsageLocation, AlternateEmailAddresses




,  e 
