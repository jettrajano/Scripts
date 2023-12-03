##Conecta ao AzureAD
Connect-AzureAD

##Pega todas as extension Attributes ativas no tenant AzureAD atribuidas a usuário/grupos/máquinas
Get-AzureADApplicationExtensionProperty
##Pega todas as extension Attributes de um Usuário
Get-AzureADUser -ObjectID "UserPrincipalName a ser testado" | Select -ExpandProperty ExtensionProperty