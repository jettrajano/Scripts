#Exporta a lista de membros do grupo de distriuição dinamico para um arquivo .csv
Get-DynamicDistributionGroupMember -ResultSize Unlimited -Identity cc.todos@hapvida.com.br | Export-Csv C:\Temp\Group_OU_5.csv
#verificar se a lista foi criada com email
Get-DynamicDistributionGroup -Identity cc.todos@hapvida.com.br
#Faz o 
Get-DynamicDistributionGroupMember -Identity teste.dist.dina@hapvida.com.br 
 $group = "CC.Todos"
(Get-Recipient -ResultSize unlimited -RecipientPreviewFilter (Get-DynamicDistributionGroup $group).RecipientFilter).count | Export-Csv c:\temp\lsit-users.csv