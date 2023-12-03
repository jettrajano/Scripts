####https://docs.microsoft.com/en-us/azure/active-directory/enterprise-users/groups-assign-sensitivity-labels
#####Habilitar suporte a etiqueta de sensibilidade no PowerShell
#Para garantir que você não efrente problemas com modulos do Azure AD é preciso desinstalar as vesões anteriores.
Uninstall-Module AzureADPreview
Uninstall-Module azuread
#Agora instale a versão mais recente do Azure AD
Install-Module AzureADPreview
#Conecte ao modulo do AzureADPreview
Connect-AzureAD
#Verifique se o ambinete está configurado, vai retornar o valor das configurações de integração AIP e grupos M365
Get-AzureADDirectorySettingTemplate
##Busque as configurações de grupo atuais para a organização Azure AD e exiba as configurações atuais do grupo. Se nenhuma configuração de grupo tiver sido criada para esta organização Azure AD, você terá uma tela vazia. Neste caso (SÃO OS COMANDOS 31, você deve primeiro criar as configurações. Siga os passos em cmdlets do Azure Active Directory "https://docs.microsoft.com/en-us/azure/active-directory/enterprise-users/groups-settings-cmdlets" para configurar configurações de grupo para criar configurações de grupo para esta organização Azure AD.
#Se o rótulo de sensibilidade tiver sido ativado anteriormente, você verá EnableMIPLabels = True. Neste caso, você não precisa fazer nada.
$grpUnifiedSetting = (Get-AzureADDirectorySetting | where -Property DisplayName -Value "Group.Unified" -EQ)
$Setting = $grpUnifiedSetting
$grpUnifiedSetting.Values
#Habilite o recurso:
$Setting["EnableMIPLabels"] = "True"
#Confira o novo valor aplicado:
$Setting.Values
#Salve as alterações e aplique as configurações:
Set-AzureADDirectorySetting -Id $grpUnifiedSetting.Id -DirectorySetting $setting
#Se você está recebendo um erro Request_BadRequest, é porque as configurações já existem no inquilino, então quando você tenta criar um novo par de propriedades:valor, o resultado é um erro. Neste caso, tome as seguintes etapas:
#Repita os passos 1-4 do Enable sensitivity label support in PowerShell.
#Emita um cmdlet e verifique a ID. Se vários valores de ID estiverem presentes, use aquele em que você vê a propriedade EnableMIPLabels nas configurações Valores. Você vai precisar da identidade na etapa 4.Get-AzureADDirectorySetting | FL
#Defina a variável de propriedade EnableMIPLabels: $Setting["EnableMIPLabels"] = "True"
#Emita o cmdlet, usando o ID que você recuperou na etapa 2.Set-AzureADDirectorySetting -DirectorySetting $Setting -ID
#Certifique-se de que o valor agora está atualizado corretamente, emitindo novamente.$Setting.Values


##################https://docs.microsoft.com/en-us/azure/active-directory/enterprise-users/groups-settings-cmdlets
############Cmdlets do Azure Active Directory para configurar configurações de grupo
#####Verifique se o ambinete está configurado, vai retornar o valor das configurações de integração AIP e grupos M365
Get-AzureADDirectorySettingTemplate
#Para adicionar uma URL de diretriz de uso, primeiro você precisa obter o objeto ConfiguraçõesTemplate que define o valor da URL da diretriz de uso; ou seja, o modelo Group.Unified:
$TemplateId = (Get-AzureADDirectorySettingTemplate | where { $_.DisplayName -eq "Group.Unified" }).Id
$Template = Get-AzureADDirectorySettingTemplate | where -Property Id -Value $TemplateId -EQ
#Em seguida, crie um novo objeto de configurações com base nesse modelo:
$Setting = $Template.CreateDirectorySetting()
#Em seguida, atualize o objeto de configurações com um novo valor. Os dois exemplos abaixo alteram o valor da diretriz de uso e permitem rótulos de sensibilidade. Defina essas ou qualquer outra configuração no modelo conforme necessário:
$Setting["UsageGuidelinesUrl"] = "https://guideline.example.com"
$Setting["EnableMIPLabels"] = "True"
#Em seguida, aplique a configuração:
New-AzureADDirectorySetting -DirectorySetting $Setting
#Você pode ler os valores usando:
$Setting.Values
#Atualizar configurações no nível do diretório Para atualizar o valor do UseGuideLinesUrl no modelo de configuração, leia as configurações atuais do Azure AD, caso contrário, podemos acabar substituindo as configurações existentes além do UseGuideLinesUrl.
#Obtenha as configurações atuais do Group.Unified SettingsTemplate:
$Setting = Get-AzureADDirectorySetting | ? { $_.DisplayName -eq "Group.Unified"}
#Confira as configurações atuais:
$Setting.Values
#Para remover o valor do UseGuideLinesUrl, edite a URL como uma sequência vazia:
$Setting["UsageGuidelinesUrl"] = ""
#Salve a atualização para o diretório
Set-AzureADDirectorySetting -Id $Setting.Id -DirectorySetting $Setting
##AO FIM DESSE PASSO REPITA OS PASSO DAS PRIMEIRA LINHAS.