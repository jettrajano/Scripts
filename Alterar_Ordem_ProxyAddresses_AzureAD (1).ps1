#####################################################################################
### Script para alterar a ordem dos emails no atributo ProxyAddresses no AzureAD  ###
#####################################################################################

# Não deve ser usado para ambiente que sincroniza AD com o M365
# Executar através do Microsoft Exchange Online Powershell Module
# OBS.: Os diretorios de destino deverão existir. Caso contrario, sera necessario utilizar outro script  

$Cred = Get-Credential
$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://ps.outlook.com/powershell/ -Credential $Cred -Authentication Basic -AllowRedirection
Import-PSSession $Session
Set-Mailbox -Identity "UPN" -EmailAddresses SMTP:EMAIL_PRINCIPAL,smtp:EMAIL_SECUNDARIO
Remove-PSSession $Session
