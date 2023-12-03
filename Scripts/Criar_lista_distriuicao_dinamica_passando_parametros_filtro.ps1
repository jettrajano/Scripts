##Criar os paremetros e filtros que serão passados para o comando SET, para criar uma lista de distriuição dinamica no Exchange online excluindo caixas de email compartilha, pasta publica, caixa de grupos
$filter = "((RecipientType -eq 'UserMailbox') -and (-not(RecipientTypeDetails -eq 'SharedMailbox')) -and(-not(Name -like 'SystemMailbox{*')) -and (-not(Name -like 'CAS_{*')) -and
(-not(RecipientTypeDetailsValue -eq 'MailboxPlan')) -and (-not(RecipientTypeDetailsValue -eq 'DiscoveryMailbox')) -and
(-not(RecipientTypeDetailsValue -eq 'PublicFolderMailbox')) -and (-not(RecipientTypeDetailsValue -eq
'ArbitrationMailbox')) -and (-not(RecipientTypeDetailsValue -eq 'AuditLogMailbox')) -and (-not(RecipientTypeDetailsValue
-eq 'AuxAuditLogMailbox')) -and (-not(RecipientTypeDetailsValue -eq 'SupervisoryReviewPolicyMailbox')) -and
(-not(RecipientTypeDetailsValue -eq 'GuestMailUser')))"

#Define os filtros coletando da váriavel $filter
Set-DynamicDistributionGroup -Identity CC.Todos -RecipientFilter $filter

#Conta a quantidade de membros adicionados de forma automatica
$group = "CC.Todos"
(Get-Recipient -ResultSize unlimited -RecipientPreviewFilter (Get-DynamicDistributionGroup $group).RecipientFilter).count