# Configurar as variáveis
$SiteURL = "https://msdx100487.sharepoint.com/"
$LibraryName = "Documents"
#$NewLibraryName = "NomeNovoDaBiblioteca"
#$UserName = "admin@MSDx100487.onmicrosoft.com"
#$Password = "iKn76N}]}O9eH]n4"

#####
##Install-Module PnP.PowerShell -Scope CurrentUser -AllowPrerelease
#install-Module PnP.PowerShell -AllowPrerelease -RequiredVersion 1.12.80-nightly -Force
#Register-PnPManagementShellAccess
#Install-Module -Name SharePointPnPPowerShellOnline -AllowClobber#
#$PSVersionTable.PSVersion
#Install-Module -Name PnP.PowerShell -Force
#Install-PackageProvider -Name NuGet -Force
#Install-Module PowerShellGet -Force
#Import-Module PnP.PowerShell -Force

#$SecurePassword = ConvertTo-SecureString $Password -AsPlainText -Force
#$Credential = New-Object System.Management.Automation.PSCredential ($UserName, $SecurePassword)

## Forçar a Importação da biblioteca PNP
Import-Module PnP.PowerShell -Force

## Conecta ao modulo
Connect-PnPOnline -Interactive -Url https://msdx100487.sharepoint.com/ #-Credentials $Credential

# Obter a biblioteca de documentos atual
$Library = Get-PnPList -Identity $LibraryName

# Renomear a biblioteca de documentos
Set-PnPList -Identity $LibraryName -Title $NewLibraryName -Force

# Desconectar do site do SharePoint Online
Disconnect-PnPOnline

