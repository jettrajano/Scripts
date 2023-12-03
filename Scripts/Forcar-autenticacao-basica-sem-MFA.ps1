Connect-MsolService 
## Forçar a autenticação basica sem MFA para admins
$EmailAddress = Read-Host -Prompt 'sou.cloud@forship.onmicrosoft.com' 
Set-MsolUser -UserPrincipalName $EmailAddress -StrongAuthenticationRequirements @()

