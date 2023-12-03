## Conectar ao serviço do SharePoint Online necessário colar o endereço raiz do SharePoint do Cliente
$Credential = Get-Credential
Connect-MsolService -Credential $Credential
Connect-SPOService -Credential $Credential -Url "DIGITAR O ENDEREÇO RAIZ DO SPO"

### Coletar a lista de usuários que você precisa provisionar importando uma lista em .csv ( A LISTA PRECISA TER APENAS OS ENDEREÇOS DE EMAILS UM ABAIXO DO OUTRO)###

## Remove o bloqueio de login dos usuários caso estejam bloqueados
Get-Content -path "C:\Temp\Usrs-OneDrive.csv" | ForEach-Object { Set-MsolUser -UserPrincipalName $_ -BlockCredential $False }

## Coleta os endereços de email da lista .csv e provisiona o OneDrive ( usuários precisam já ter licença atribuida antes)
$users = Get-Content -path "C:\Temp\Usrs-OneDrive.csv"
Request-SPOPersonalSite -UserEmails $users