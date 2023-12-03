$orgName="msdx395016.onmicrosoft.com"
$acctName="admin@MSDx395016.onmicrosoft.com"
$credential = Get-Credential -UserName $acctName -Message "Type the account's password."
#Azure Active Directory
Connect-AzureAD -Credential $credential
#SharePoint Online
$credential = New-Object -TypeName System.Management.Automation.PSCredential -argumentlist $credential #, $(convertto-securestring $Password -asplaintext -force)
Connect-SPOService -Url https://$orgName-admin.sharepoint.com -Credential $credential
#Exchange Online
Import-Module ExchangeOnlineManagement
Connect-ExchangeOnline -ShowProgress $true
#Security & Compliance Center
Connect-IPPSSession -UserPrincipalName $acctName
#Teams and Skype for Business Online
Import-Module MicrosoftTeams
Import-Module Microsoft.Online.SharePoint.PowerShell -DisableNameChecking
Connect-MicrosoftTeams -Credential $credential

#####Fechar as conexões
Disconnect-AadrmServic ; Disconnect-AipService ;  Disconnect-AzureAD ; Disconnect-AzAccount ; Disconnect-ExchangeOnline ; #Disconnect-PSSession

##Rode esse comando para liberar a execução de usuário remoto na máquina local
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope LocalMachine
##Rode esse comando para liberar a execução de usuário remoto na sessão de usuário ativa
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
##Rode esse comando para visualizar se as politicas foram configuradas
Get-ExecutionPolicy -List
##Rode esse comando para ativar o PowerShell no menu de contexto precisa reiniciar a máquina
msiexec.exe /package PowerShell-7.2.0-win-x64.msi /quiet ADD_EXPLORER_CONTEXT_MENU_OPENPOWERSHELL=1 ENABLE_PSREMOTING=1 REGISTER_MANIFEST=1
##Rode para instalar o modulo NuGet para modulos de administração do AzureAD
Install-PackageProvider -Name NuGet -Force
##Rode para completar e forçar a instalação do PowerShell galery onde vai ter todos os principais modúlos do PS
Install-Module -Name PowerShellGet -Force -AllowClobber
##Rode para atualizar os modúlos do PSGallery
Update-Module -Name PowerShellGet
##Rode para ativar o modulo do AzureAD após finalização do PSGallery
Install-Module -Name AzureAD
##Rode para ativar o modulo do AIPService após finalização do PSGallery
Install-Module -Name AIPService
##Rode para ativar o modulo do Serviços do Microsoft Online após finalização do PSGallery
Install-Module MSOnline
##Rode para ativar o modulo do Exchange Online v2 pós finalização do PSGallery
Install-Module -Name ExchangeOnlineManagement -RequiredVersion 2.0.5
##Rode para atualizar o modulo do Exchange Online v2 pós finalização da instalação do Exchange V2
Update-Module -Name PackageManagement
##Rodar para Instalar modulo de senha AD
Install-Module -name AdmPwd.PS
Install-Module -name microsoftteams
Install-Module Microsoft.Online.SharePoint.PowerShell
Import-Module AIPService
Install-Module AzureADPreview -Force
Import-Module AzureADPreview
Connect-AzureAD
Connect-AipService
Execute-AzureAdLabelSync
 Set-SPOTenant -EnableAIPIntegration $true
 Update-Module -Name Microsoft.Online.SharePoint.PowerShell
 Execute-AzureAdLabelSync
 $Setting.Values
  $Setting["EnableMIPLabels"] = "True"
   $Setting.Values
   Set-AzureADDirectorySetting -Id $grpUnifiedSetting.Id -DirectorySetting $setting