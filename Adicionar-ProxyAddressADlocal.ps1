# Importar o módulo Active Directory
Import-Module ActiveDirectory

# Importar usuários do arquivo CSV
$users = Import-Csv -Path C:\caminho\para\seu\arquivo.csv

foreach ($user in $users) {
    # Obter o SamAccountName do arquivo CSV
    $samAccountName = $user.SamAccountName

    # Construir os endereços de email
    $email1 = $samAccountName + "@pratidonaduzzi.onmicrosoft.com"
    $email2 = $samAccountName + "@pratidonaduzzi.mail.onmicrosoft.com"

    # Obter o usuário do Active Directory
    $adUser = Get-ADUser -Filter "SamAccountName -eq '$samAccountName'"

    if ($adUser) {
        # Adicionar os endereços de email como proxy
        Set-ADUser -Identity $adUser.SamAccountName -Add @{proxyAddresses = "SMTP:$email1", "smtp:$email2"}
    }
}
