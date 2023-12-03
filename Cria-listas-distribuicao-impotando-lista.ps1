##Conectar ao processo de criação dos grupos
$365Logon = Get-Credential
$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://outlook.office365.com/powershell-liveid/ -Credential $365Logon -Authentication Basic -AllowRedirection
Import-PSSession $Session
#Importa lista do diretório local
$pahtlista = "C:\Temp\distlistgroup.csv"
#Le a lista de grupos
$lista = Import-csv $pahtlista #-Delimiter ","
#Parametro para contar o número de grupos
$cont = 1
#Looping para criar os grupos
foreach($iten in $lista){
#criar as váriaveis com base na lista importada nos comandos anteriores
$gpName = $iten.Name
$gpDisplayName = $iten.DisplayName
$gpMail = $iten.PrimarySmtpAddress
$gpAlias = $iten.Alias
#Escreve na tela do PS os detalhes dos grupos que estão sendo criados
Write-Host($cont, "-", $gpName)
#Conta parametro para mostrar os grupos que estão na lista de criação
$cont ++
#Comando de criação de grupos de seurança
New-DistributionGroup -Name $gpName -DisplayName $gpDisplayName -Alias $gpAlias -PrimarySmtpAddress $gpMail
}

Get-DistributionGroup