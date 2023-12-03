# Importar módulo Active Directory
Import-Module ActiveDirectory

# Importar usuários do arquivo CSV
$usuarios = Import-Csv -Path C:\Temp\ListaUsersRemoverProxy.csv

foreach ($usuario in $usuarios) {
    # Obter o usuário do Active Directory
    $adUser = Get-ADUser -Identity $usuario.sAMAccountName -Properties proxyaddresses

    # Verificar se o usuário tem endereços de proxy
    if ($adUser.proxyaddresses) {
        # Filtrar o endereço de proxy que deseja remover
        $proxyToRemove = $adUser.proxyaddresses -match "pratidomain.local"

        if ($proxyToRemove) {
            # Remover o endereço de proxy
            Set-ADUser -Identity $usuario.sAMAccountName -Remove @{proxyaddresses=$proxyToRemove}
            Write-Host "Endereço de proxy removido para o usuário $($usuario.sAMAccountName)"
        } else {
            Write-Host "Nenhum endereço de proxy correspondente encontrado para o usuário $($usuario.sAMAccountName)"
        }
    } else {
        Write-Host "O usuário $($usuario.sAMAccountName) não tem endereços de proxy"
    }
}
