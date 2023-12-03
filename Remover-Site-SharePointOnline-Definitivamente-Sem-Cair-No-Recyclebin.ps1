###Selecionar das linhas 2 até a linha 5 e executar clicando no botão da folhinha com setinha verde
##Para executar o comando todo de uma vez antes na Lina 9 coloque o endereço correto do site que deseja remover definitivamente (NÃO É POSSÍVEL RESTAURAR O SITE OU CONTEÚDO APÓS ESSE COMANDO)
$acctName="claudinei_moretti@diocese.org.br"
$credential = Get-Credential -UserName $acctName -Message "Digite sua senha"
$credential = New-Object -TypeName System.Management.Automation.PSCredential -argumentlist $credential #, $(convertto-securestring $Password -asplaintext -force)
Connect-SPOService -Url https://mitranh-admin.sharepoint.com -Credential $credential
##
#####Colar colar o nome do site que deseja remover definitivamente no fim do caminho  https://mitranh.sharepoint.com/sites/nome do site exemplo Pastorais
Remove-SPODeletedSite -Identity https://mitranh.sharepoint.com/sites/Pastorais