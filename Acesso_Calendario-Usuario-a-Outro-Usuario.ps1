## Conjuto de comandos para importa e conectar ao serviço de Exchange Online rode os comandos import-module e conect-Exchange juntos (necessario às permissões Exchange Admin, Global Admin)
Import-Module ExchangeOnlineManagement
Connect-ExchangeOnline -ShowProgress $true

# Verificar e validar as permissões que o usuário possui
Get-MailboxFolderPermission -Identity emaildoUsuário:\calendário | fl *

# Adicionar uma permissão de leitor e revisor de outros calendários
Add-MailboxFolderPermission -Identity fabiana@sou.cloud:\Calendário -User caio@sou.cloud -AccessRights Reviewer

# Caso precise mudar a permissão utilizar o comando abaixo:
Set-MailboxFolderPermission -Identity bruno@sou.cloud:\Calendário -User caio@sou.cloud -AccessRights Reviewer


$0 = caio@sou.cloud
$1 = bruno@sou.cloud
#$2 = darliane@sou.cloud
#djoni@sou.cloud
$3 = eder@sou.cloud
$4 = edison@sou.cloud
$5 = elvis@sou.cloud
$6 = gustavo@sou.cloud
$7 = marco@sou.cloud
$8 = mateus@sou.cloud
$9 = moara@sou.cloud
#ozeia@sou.cloud
$10 = cortijo@sou.cloud
$11 = fabiob@sou.cloud
$12 = gattini@sou.cloud
$13 = jessica@sou.cloud
$14 = marcosl@sou.cloud
$15 = thiago@sou.cloud
$16 = vicentinni@sou.cloud
$17 = ana@sou.cloud
$18 = andrea@sou.cloud
$19 = fabiana@sou.cloud
# Proprietário – oferece controle total da pasta da caixa de correio: ler, criar, modificar e excluir todos os itens e pastas. Além disso, esta função permite gerenciar permissões de itens;
# Editor de Publicação – ler, criar, modificar e excluir itens / subpastas (todas as permissões, exceto o direito de alterar as permissões);
# Editor – leia, crie, modifique e exclua itens (não é possível criar subpastas);
# PublishingAuthor – cria, lê todos os itens / subpastas. Você pode modificar e excluir apenas os itens criados;
# Autor – cria e lê itens; editar e excluir os próprios itens;
# NonEditingAuthor – acesso de leitura total e criação de itens. Você pode excluir apenas seus próprios itens;
# Revisor – somente ler itens da pasta;
# Contribuidor – cria itens e pastas (não pode ler itens);
# AvailabilityOnly – leia as informações de Livre / Ocupado do calendário;
# LimitedDetails ;
# Nenhum – nenhuma permissão para acessar pastas e arquivos.