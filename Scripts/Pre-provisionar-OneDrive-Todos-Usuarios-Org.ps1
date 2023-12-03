## Conectar ao SharePoint do cliente para realizar o provisionamento do OneDrive de todos os usuários ativos e com licenças
$Credential = Get-Credential
Connect-MsolService -Credential $Credential
Connect-SPOService -Credential $Credential -Url "ADICIONE AQUI O URL DA RAIZ DO SHAREPOINT SEM APAS"

## Listar todos os usuários direto no tenant
$list = @()
#Counters
$i = 0


##Coletar todos os usuários licenciados
$users = Get-MsolUser -All | Where-Object { $_.islicensed -eq $true }
##Contar o total de usuários
$count = $users.count
## Iniciar bloco de provisionamento de OneDrive imprimindo na tela
foreach ($u in $users) {
    $i++
    Write-Host "$i/$count"

    $upn = $u.userprincipalname
    $list += $upn

    if ($i -eq 199) {
        #Limite de contas que podem ser feitas de uma vez 199
        Request-SPOPersonalSite -UserEmails $list -NoWait
        Start-Sleep -Milliseconds 655
        $list = @()
        $i = 0
    }
}

if ($i -gt 0) {
    Request-SPOPersonalSite -UserEmails $list -NoWait
}