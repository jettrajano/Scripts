##Conectar ao processo de criação dos grupos
$365Logon = Get-Credential
$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://outlook.office365.com/powershell-liveid/ -Credential $365Logon -Authentication Basic -AllowRedirection
Import-PSSession $Session
#Importa lista do diretório local
$pahtlista = "C:\Temp\Usersgroup.csv"
#Le a lista para adicionar ao grupos
$lista = Import-csv $pahtlista #-Delimiter ","
#Parametro para contar o número de grupos
$cont = 1
#Looping para criar os grupos
foreach($iten in $lista){
#criar as váriaveis com base na lista importada nos comandos anteriores
$gpidentity = $iten.Identity
$gpUPN = $iten.UPN
#Escreve na tela do PS os detalhes dos grupos que estão sendo criados
Write-Host($cont, "-", $gpidentity,$gpUPN)
#Conta parametro para mostrar os grupos que estão na lista de criação
$cont ++
#Comando de incluisão dos membros no grupo
Add-DistributionGroupMember -Identity $gpidentity  -Member $gpUPN
}
Get-DistributionGroup Salas@construtoraplaneta.onmicrosoft.com | Set-DistributionGroup -ExternalDirectoryObjectId