##Testar_Licencas_Usuarios_Lista_From_CSV_V2
##Instala e conecta ao AzureAD só é necessário fazer uma vez executando o PowerShell em modo Administrador
Install-Module -Name AzureAD
##Primeiro passo é conectar ao AzureAD da empresa que você vai testar as licenças
Connect-AzureAD
##Instala e conecta ao MSOnline só é necessário fazer uma vez executando o PowerShell em modo Administrador
Install-Module MSOnline
##Segundo passo importe o modúlo MsOnline para conectar com seu usuário M365
Import-Module MsOnline
##Terceiro passo Conecte aos serviços MsOnline
Connect-MsolService
##Autentica o serviço MSOline para coletar de forma completa as licenças dos usuários usando UPN na primeira etapa
$credential = Get-Credential
Connect-MsolService -Credential $credential
Get-MsolDomain
##Testa licença de usuário importando de uma lista CSV
$pathlista = "C:\temp\UPN_Users_to_Tester.csv"
$lista = Import-Csv $pathlista #-Delimiter ","
$cont = 1
foreach($item in $lista){
    #cria as variáveis com base no csv
    $identity = $item.UserPrincipalName    
    #imprime na tela o andamento
    Write-Host($cont,"-",$identity)
    $cont ++
    Get-MsolUser -UserPrincipalName $identity | Select-Object UserPrincipalName, DisplayName, Licenses, LastDirSyncTime, Department, UsageLocation, AlternateEmailAddresses
}
## Mostra propriedades do usuário informado pelo UPN

##USUÁRIAo individual para testar remova o jogo da velha antes do get-Msoluser
#Get-MsolUser -UserPrincipalName Pedro_Davoglio@onelinde.com | Select-Object UserPrincipalName, DisplayName, Licenses, LastDirSyncTime, Department, UsageLocation, AlternateEmailAddresses
