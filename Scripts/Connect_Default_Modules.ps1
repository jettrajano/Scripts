################################################################################################################################################
## Script para conectar com todos os serviços de uma vez só:
## https://gallery.technet.microsoft.com/PowerShell-Script-to-4081ec0f?ranMID=43674&ranEAID=je6NUbpObpQ&ranSiteID=je6NUbpObpQ-rwDlZMHS_z88dhc9nYMAOw&epi=je6NUbpObpQ-rwDlZMHS_z88dhc9nYMAOw&irgwc=1&OCID=AID2000142_aff_7795_1243925&tduid=$ir__wnw2k2bs1gkfry2e0jd6oxxa1e2xng0m62din0s100$$7795$$1243925$$je6NUbpObpQ-rwDlZMHS_z88dhc9nYMAOw$$$&irclickid=_wnw2k2bs1gkfry2e0jd6oxxa1e2xng0m62din0s100
## Instruções:
## https://o365reports.com/2019/10/05/connect-all-office-365-services-powershell/?src=technet#Connect%C2%A0to%C2%A0Exchange%20Online%20PowerShell%20with%20MFA
## Teams > Suporte > PowerShell > ConnectO365Services.ps1
##
## Artigo que explica como conectar com vários serviços do O365 numa única janela de PS
## ## https://docs.microsoft.com/en-us/office365/enterprise/powershell/connect-to-all-office-365-services-in-a-single-windows-powershell-window
##
## Documentação dos cmdlets do Office 365
## https://docs.microsoft.com/en-us/office365/enterprise/powershell/cmdlet-references-for-office-365-services
##
################################################################################################################################################

## --------------------------------------------------------------------------------------------------------------------------------------------
## PRE-REQS
## --------------------------------------------------------------------------------------------------------------------------------------------
## Windows 64 Bits
## Microsoft Online Services Sign-In Assistant for IT Professionals RTW
## Windows PowerShell precisa permitir rodar scripts assinados remotamente para Skype for Business Online e Security & Compliance Center.
Set-ExecutionPolicy RemoteSigned
Get-ExecutionPolicy -List
## Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Scope Process (utilizado as vezes para permitir acesso mais amplo de execução)
## Versão do PowerShell > 5
$PSVersionTable

## --------------------------------------------------------------------------------------------------------------------------------------------
## MS ONLINE SIGNIN ASSISTANT
## --------------------------------------------------------------------------------------------------------------------------------------------
## Microsoft Online Services Sign-In Assistant for IT Professionals RTW
## Instalar > https://www.microsoft.com/en-us/download/details.aspx?id=41950
## Utilizado com o Azure AD Module for Windows PowerShell

## --------------------------------------------------------------------------------------------------------------------------------------------
## Seis Módulos:
## --------------------------------------------------------------------------------------------------------------------------------------------
## 1. Office 365 PowerShell
## 2. SharePoint Online
## 3. Skype for Business Online
## 4. Exchange Online
## 5. Microsoft Teams
## 6. Security & Compliance Center

## --------------------------------------------------------------------------------------------------------------------------------------------
## LISTA MÓDULOS INSTALADOS
## --------------------------------------------------------------------------------------------------------------------------------------------
Get-InstalledModule -Name *
Get-InstalledModule -Name AzureAD -AllVersions
Get-InstalledModule -Name MSonline -AllVersions
Get-Module -Name Microsoft.Online.SharePoint.PowerShell -ListAvailable | Select Version, Name, Description
Get-InstalledModule -Name Az -AllVersions ## (Azure)

## --------------------------------------------------------------------------------------------------------------------------------------------
## 1. OFFICE 365 POWERSHELL (2 módulos são necessários)
## --------------------------------------------------------------------------------------------------------------------------------------------
## Artigo que explica como instalar o modulo: Office 365 PowerShell 
## https://docs.microsoft.com/en-us/office365/enterprise/powershell/connect-to-office-365-powershell##connect-with-the-azure-active-directory-powershell-for-graph-module

## Azure Active Directory PowerShell for Graph (ainda incompleto comparado ao MSol*)
## AzureAD* cmdlets
## Documentação cmdlets > https://docs.microsoft.com/en-us/powershell/module/azuread/?view=azureadps-2.0
## Última versão >  https://www.powershellgallery.com/packages/AzureAD
## Instalação (uma vez só)
Install-Module -Name AzureAD
## Conecta com nome e senha e MFA!!
Connect-AzureAD
## Confere que conectou listando info do Tenant
Get-AzureADTenantDetail
## Disconecta
Disconnect-AzureAD
## Remover
Uninstall-Module -Name AzureAD -Force

## Microsoft Azure Active Directory Module for Windows PowerShell (versão mais antiga)
## MSol* cmdlets 
## Documentação cmdlets > https://docs.microsoft.com/en-us/powershell/module/msonline/?view=azureadps-1.0
## Última versão > https://www.powershellgallery.com/packages/MSOnline
## Instalação (uma vez só)
Install-Module MSOnline
## Remover
Uninstall-Module -Name MSonline -Force 
## Conecta com nome e senha e MFA!!
$credential = Get-Credential
Connect-MsolService -Credential $credential
## Confere que conectou listando info de domínios
Get-MsolDomain

## --------------------------------------------------------------------------------------------------------------------------------------------
## 2. SHAREPOINT ONLINE MANAGEMENT SHELL
## --------------------------------------------------------------------------------------------------------------------------------------------
## Documentação do módulo > https://docs.microsoft.com/en-us/powershell/sharepoint/sharepoint-online/connect-sharepoint-online?view=sharepoint-ps
## Última versã0 > https://www.powershellgallery.com/packages/Microsoft.Online.SharePoint.PowerShell
## Mais utilizado para gestão de site collection
## Documentação cmdlets > https://docs.microsoft.com/en-us/powershell/module/sharepoint-online/?view=sharepoint-ps
## Instalação (uma vez só)
Install-Module -Name Microsoft.Online.SharePoint.PowerShell
## Conecta com nome e senha e MFA!!
Import-Module Microsoft.Online.SharePoint.PowerShell -DisableNameChecking
## "4mstech.onmicrosoft.com",  <domainhost> = "4mstech" ==> Connect-SPOService -Url https://<domainhost>-admin.sharepoint.com
Connect-SPOService -Url https://4mstech-admin.sharepoint.com
## Confere que conectou listando sites
Get-SPOSite
## Disconecta
Disconnect-SPOService

## --------------------------------------------------------------------------------------------------------------------------------------------
## 3. SKYPE FOR BUSINESS ONLINE
## --------------------------------------------------------------------------------------------------------------------------------------------
## Documentação do módulo > 
## Instalar > https://www.microsoft.com/en-us/download/details.aspx?id=39366
## Documentação cmdlets > https://docs.microsoft.com/en-us/powershell/module/skype/?view=skype-ps
## Instalação (uma vez só)
## Versão? Verificar em Add and Remove Programs 
## Se der erro de ExecutionPolicy
Get-ExecutionPolicy -List ## se estiver Undefinied, será usado como padrão Restriced
Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Scope Process ## permite Unrestricted na sessão corrente 
## Conecta com nome e senha e MFA!!
Import-Module SkypeOnlineConnector
$sfboSession = New-CsOnlineSession
Import-PSSession $sfboSession
## Confere que conectou listando o status dos domínios
Get-CsOnlineSipDomain
## Disconecta
Remove-PSSession $sfboSession

## --------------------------------------------------------------------------------------------------------------------------------------------
## 4. EXCHANGE ONLINE
## --------------------------------------------------------------------------------------------------------------------------------------------
## Instalar sem MFA > https://docs.microsoft.com/en-us/powershell/exchange/exchange-online/connect-to-exchange-online-powershell/connect-to-exchange-online-powershell?view=exchange-ps
## Instalar com MFA > https://docs.microsoft.com/en-us/powershell/exchange/exchange-online/connect-to-exchange-online-powershell/mfa-connect-to-exchange-online-powershell?view=exchange-ps
## OBS: Instalação (uma vez só), tem que usar o IE para baixar e instalar do portal do Exchange > Hybrid
## Instalar v2 (preview) > https://docs.microsoft.com/en-us/powershell/exchange/exchange-online/exchange-online-powershell-v2/exchange-online-powershell-v2?view=exchange-ps
## Documentação cmdlets > 
## Conecta com nome e senha e MFA!!
## Abrir Exchange Online Remote PowerShell Module
Connect-EXOPSSession -UserPrincipalName jlabre@4mstech.com
Get-PSSession | Remove-PSSession
## Confere que conectou listando info de domínios
Get-AcceptedDomain

## --------------------------------------------------------------------------------------------------------------------------------------------
## 5. TEAMS
## --------------------------------------------------------------------------------------------------------------------------------------------
## São necessários dois módulos para trabalhar com o Teams, o do próprio Teams e o do SfB
## Documentação > https://docs.microsoft.com/en-us/MicrosoftTeams/teams-powershell-overview
## Instalação > https://www.powershellgallery.com/packages/MicrosoftTeams/1.0.6
## Documentação cmdlets > https://docs.microsoft.com/en-us/powershell/module/teams/?view=teams-ps
## Instalação (uma vez só)
Install-Module -Name MicrosoftTeams
## Conecta com o serviço do Teams
Connect-MicrosoftTeams
## Confere que conectou listando os Teams
Get-Team
## Disconecta
Disconnect-MicrosoftTeams

## --------------------------------------------------------------------------------------------------------------------------------------------
## 6. SECURITY & COMPLIANCE
## --------------------------------------------------------------------------------------------------------------------------------------------
## Instalar sem MFA > https://docs.microsoft.com/en-us/powershell/exchange/office-365-scc/connect-to-scc-powershell/connect-to-scc-powershell?view=exchange-ps
## Instalar com MFA > https://docs.microsoft.com/en-us/powershell/exchange/office-365-scc/connect-to-scc-powershell/mfa-connect-to-scc-powershell?view=exchange-ps
## Necessário instalar o Exchange Online Remote PowerShell Module
## OBS: Instalação (uma vez só), tem que usar o IE para baixar e instalar do portal do Exchange > Hybrid
## Conecta Security & Compliance Center e adiciona a string `cc´ como prefixo do comando Get-RoleGroup vira Get-ccRoleGroup, para evitar mesmo comando já registado pelo Exchange
## Abrir Exchange Online Remote PowerShell Module
Connect-IPPSSession -UserPrincipalName jlabre@4mstech.com
## Confere que conectou
Get-RetentionCompliancePolicy

## --------------------------------------------------------------------------------------------------------------------------------------------
## FECHANDO TODAS AS SEÇÕES
## --------------------------------------------------------------------------------------------------------------------------------------------
## 
Get-PSSession
Remove-PSSession $sfboSession
## Remove-PSSession $exchangeSession
## Remove-PSSession $ccSession
Disconnect-SPOService
## ou todos numa linha 
Get-PSSession | Remove-PSSession

## Para o MSonline pode simplesmente fechar a janela do PS



################################################################################################################################################
