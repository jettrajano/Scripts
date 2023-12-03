# Define as credenciais do usuário administrador do Exchange Online
$UserCredential = Get-Credential

# Conecta ao Exchange Online
$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://outlook.office365.com/powershell-liveid/ -Credential $UserCredential -Authentication Basic -AllowRedirection
Import-PSSession $Session

# Define o endereço de email do usuário a ser migrado
$UserEmailAddress = "maria.silva@bib.com.br"

# Completa a migração híbrida para o usuário específico
Start-MigrationBatch -Identity $UserEmailAddress -RemoteHostName "MCORP01.LINKED" -RemoteCredential (Get-Credential) -TargetDeliveryDomain "bancoindustrialcsp.mail.onmicrosoft.com"

# Verifica o status da migração
Get-MigrationUser -Identity $UserEmailAddress | Select DisplayName, TargetDeliveryDomain, TargetGlobalAdmin, @{Name="Status"; Expression={If ($_.InSync -eq $True) {"Sincronizado"} Else {"Não sincronizado"}}}

# Remove a sessão do Exchange Online
Remove-PSSession $Session


Hybrid Migration Endpoint - EWS (Default Web Site)