## Importar e conectar ao Exchange EXO V2
Import-Module ExchangeOnlineManagement
Connect-ExchangeOnline -ShowProgress $true
#Security & Compliance Center
Connect-IPPSSession -UserPrincipalName $acctName

## Seiga os links para ler os procedimentos
## 1 - https://docs.microsoft.com/pt-br/exchange/security-and-compliance/recoverable-items-folder/clean-up-deleted-items
## 2 - https://docs.microsoft.com/pt-br/microsoft-365/compliance/delete-items-in-the-recoverable-items-folder-of-mailboxes-on-hold?view=o365-worldwide
## 3 - https://docs.microsoft.com/pt-br/microsoft-365/compliance/use-content-search-for-targeted-collections?view=o365-worldwide#step-1-run-the-script-to-get-a-list-of-folders-for-a-mailbox-or-site

## Depois de criar uma pesquisa de conteúdo e validar que ela retorna os itens que você deseja excluir, use New-ComplianceSearchAction -Purge -PurgeType HardDelete o comando (no PowerShell de Conformidade com o & de Segurança) para excluir permanentemente os itens retornados pela pesquisa de conteúdo que você criou na etapa anterior. Por exemplo, você pode executar um comando semelhante ao seguinte comando:
New-ComplianceSearchAction -SearchName "Itens Excluídos" -Purge -PurgeType HardDelete

## Execute o comando a seguir para obter o tamanho atual e o número total de itens em pastas e subpastas na pasta Itens Recuperáveis na caixa de correio principal do usuário.
Get-MailboxFolderStatistics kluz@aisin.com.br -FolderScope RecoverableItems | FL Name,FolderAndSubfolderSize,ItemsInFolderAndSubfolders

## Execute o comando a seguir para obter o tamanho e o número total de itens em pastas e subpastas na pasta Itens Recuperáveis na caixa de correio de arquivo morto do usuário.
Get-MailboxFolderStatistics kluz@aisin.com.br -FolderScope RecoverableItems -Archive | FL Name,FolderAndSubfolderSize,ItemsInFolderAndSubfolders

## Execute o comando a seguir para obter informações sobre a recuperação de item único e o período de retenção de item excluído.
Get-Mailbox kluz@aisin.com.br | FL SingleItemRecoveryEnabled,RetainDeletedItemsFor

## Execute o comando a seguir para obter as configurações de acesso à caixa de correio.
Get-CASMailbox kluz@aisin.com.br | FL EwsEnabled,ActiveSyncEnabled,MAPIEnabled,OWAEnabled,ImapEnabled,PopEnabled

## Execute o comando a seguir para obter informações sobre as retenções e as políticas de retenção aplicadas à caixa de correio.
Get-Mailbox kluz@aisin.com.br | FL LitigationHoldEnabled,InPlaceHolds 

## Execute o comando a seguir para determinar se uma retenção de atraso é aplicada à caixa de correio.
Get-Mailbox kluz@aisin.com.br | FL DelayHoldApplied,DelayReleaseHoldApplied

## Execute o comando a seguir para obter o tamanho atual e o número total de itens em pastas e subpastas na pasta Itens Recuperáveis na caixa de correio principal do usuário.
Get-MailboxFolderStatistics kluz@aisin.com.br -FolderScope RecoverableItems | FL Name,FolderAndSubfolderSize,ItemsInFolderAndSubfolders

## Se a caixa de correio de arquivo morto do usuário estiver habilitada, execute o comando a seguir para obter o tamanho e o número total de itens em pastas e subpastas na pasta Itens Recuperáveis em sua caixa de correio de arquivo morto.
Get-MailboxFolderStatistics kluz@aisin.com.br  -FolderScope RecoverableItems -Archive | FL Name,FolderAndSubfolderSize,ItemsInFolderAndSubfolders
