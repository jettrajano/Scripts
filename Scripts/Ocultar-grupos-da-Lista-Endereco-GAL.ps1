## Conjuto de comandos para importa e conectar ao serviço de Exchange Online rode os comandos import-module e conect-Exchange juntos (necessario às permissões Exchange Admin, Global Admin)
Import-Module ExchangeOnlineManagement
Connect-ExchangeOnline -ShowProgress $true
## Ocultar todos os grupos 365 da lista de endereço
$Groups = Get-UnifiedGroup -ResultSize Unlimited | ? {$_.PrimarySmtpAddress -like "Section_*"}
Foreach ($Group in $Groups) {Set-UnifiedGroup -Identity $Group.Name -HiddenFromAddressListsEnabled $true}

## ocultar um grupo por da lista de endereços
Teste em um grupo primeiro para saber se vai funcionar usa esse comando
Set-UnifiedGroup -Identity <UnifiedGroupIdParameter> -HiddenFromAddressListsEnabled $true

