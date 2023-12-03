
Connect-MsolService -Credential $credential
Import-Module ExchangeOnlineManagement
Connect-ExchangeOnline -ShowProgress $true
Import-Module AzureADPreview

Connect-AzureAD
Connect-AipService

Get-IRMConfiguration | fl AzureRMSLicensingEnabled

Set-IRMConfiguration -AzureRMSLicensingEnabled:$True

Test-IRMConfiguration -Sender AdeleV@MSDx155310.OnMicrosoft.com -Recipient tadeu@sou.cloud


Get-OMEConfiguration

New-OMEConfiguration -Identity "Teste - Expire in seven days" -ExternalMailExpiryInDays 7

New-TransportRule -Name "Encrypt all mails to Fabrikam" -FromScope InOrganization -RecipientDomainIs "fabrikam.com" -ApplyRightsProtectionCustomizationTemplate "OME Configuration"