## https://lesperrieres.org/pt/gerenciando-as-regras-do-outlook-dos-usu%C3%A1rios-do-shell-de-gerenciamento-do-exchange-com-o-powershell/#Get-InboxRule

## Conectar ao serviço do SharePoint Online necessário colar o endereço raiz do SharePoint do Cliente
Import-Module ExchangeOnlineManagement
Connect-ExchangeOnline -ShowProgress $true

## Visualizar todas as regras definidas para uma caixa de correio específica. Em sua forma básica, parece que:
Get-InboxRule -Mailbox <mailbox_name>

## Como você pode ver, cada regra tem seu próprio parâmetro ruleidentity distinto. Este parâmetro pode ser usado para visualizar suas configurações e descrição, assim:
Get-InboxRule –Mailbox <mailbox_name> -Identity <number> | FL

## Visualização de regras do Outlook pelo nome e descrição
Get-InboxRule -Mailbox <mailbox_name> | Select Name, Description | FL