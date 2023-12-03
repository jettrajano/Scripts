Connect-SPOService -Url https://jeracapitalcombr-admin.sharepoint.com

Connect-IPPSSession -UserPrincipalName soucloud@jeracapital.com.br

Import-Module ExchangeOnlineManagement

$UserCredential = Get-Credential

Connect-IPPSSession -Credential $UserCredential


Install-Module AzureADPreview -AllowClobber
Import-Module AzureADPreview
Connect-AzureAD 

Uninstall-Module AzureADPreview -AllVersions
Uninstall-Module azuread

Get-AzureADDirectorySettingTemplate
$grpUnifiedSetting = (Get-AzureADDirectorySetting | where -Property DisplayName -Value "Group.Unified" -EQ)
$Setting = $grpUnifiedSetting
$grpUnifiedSetting.Values