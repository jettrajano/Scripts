##Para ativar o serviço Exchange Online Plan 2 de uma licença Microsoft E3 usando o PowerShell, siga as etapas abaixo:

## Abra o PowerShell como administrador.
##Conecte-se ao Microsoft Exchange Online usando o seguinte comando:
## Conectar ao serviço do Exchange online para validar licença
##Substitua <UPN> pelo nome principal do usuário (User Principal Name) do usuário que tem permissões para ativar o Exchange Online Plan 2.
Connect-ExchangeOnline -UserPrincipalName <UPN> -ShowProgress $true

## Verifique se a licença Microsoft E3 está atribuída ao usuário com o seguinte comando:
## Substitua <UPN> pelo nome principal do usuário.
Get-MsolUser -UserPrincipalName nathalia.bertuzzi@bib.com.br | Select-Object -ExpandProperty Licenses

## Se a licença E3 estiver atribuída, adicione o serviço Exchange Online Plan 2 com o seguinte comando:
## Substitua <UPN> pelo nome principal do usuário e <AccountSkuId> pelo ID do SKU da conta Exchange Online Plan 2. O ID do SKU para o Exchange Online Plan 2 é "EXCHANGEENTERPRISE".
Set-MsolUserLicense -UserPrincipalName <UPN> -AddLicenses "<AccountSkuId>"


## Verifique se o serviço Exchange Online Plan 2 foi adicionado com o seguinte comando:
## Substitua <UPN> pelo nome principal do usuário.
Get-MsolUser -UserPrincipalName <UPN> | Select-Object -ExpandProperty Licenses


##Após seguir essas etapas, o serviço Exchange Online Plan 2 deve ser ativado para o usuário.

$licenseObject = New-MsolLicenseOptions -AccountSkuId reseller-account:SPE_E3 ` -DisabledPlans "EXCHANGE_S_ENTERPRISE"#, "<Plan 2>"
Set-MsolUserLicense -UserPrincipalName nathalia.bertuzzi@bib.com.br `  -LicenseOptions $licenseObject
(Get-MsolUser -UserPrincipalName nathalia.bertuzzi@bib.com.br).Licenses.ServiceStatus