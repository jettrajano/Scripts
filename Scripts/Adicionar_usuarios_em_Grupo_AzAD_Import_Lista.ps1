#Conecta ao Azure Active Directory
Connect-AzureAD -Credential $credential
#Conecta aos serviços do Microsoft 365
Connect-MsolService -Credential $credential
#Importa lista do diretório local
$pahtlista = "C:\Temp\AddUserGroup.csv"
#Le a lista de grupos
$lista = Import-csv $pahtlista #-Delimiter ","
#Parametro para contar o número de grupos
$cont = 1
#Looping para criar os grupos
foreach($iten in $lista){
#criar as váriaveis com base na lista importada nos comandos anteriores
$GPID = $iten.ObjectId
$UserId = $iten.RefObjectId
#Escreve na tela do PS os detalhes dos grupos que estão sendo criados
Write-Host($cont, "-", $GPID)
#Conta parametro para mostrar os grupos que estão na lista de criação
$cont ++
#Comando de Adicionar usuários no grupos de seurança
Add-AzureADGroupMember -ObjectId $GPID -RefObjectId $UserId
}