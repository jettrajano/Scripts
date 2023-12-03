# Importando os módulos do Exchange Online e Outlook
if (!(Get-Module -Name ExchangeOnlineManagement -ErrorAction SilentlyContinue)) {
    Install-Module -Name ExchangeOnlineManagement -Force -AllowClobber
}
Import-Module ExchangeOnlineManagement

# Conectando-se ao Exchange Online
Connect-ExchangeOnline -UserPrincipalName "seuemail@dominio.com"

# Definindo o endereço de e-mail do usuário cujo calendário será adicionado à sua lista
$UsuarioCalendario = "email.do.usuario@dominio.com"

# Obtendo o calendário do usuário
$CalendarioUsuario = Get-MailboxFolderPermission -Identity "$UsuarioCalendario:\Calendar" -ErrorAction SilentlyContinue

if ($CalendarioUsuario) {
    # Adicionando o calendário do usuário à sua lista de calendários
    Add-MailboxFolderPermission -Identity "$($CalendarioUsuario.Identity)" -User "seuemail@dominio.com" -AccessRights Reviewer -AutoMapping $true

    Write-Host "O calendário de $UsuarioCalendario foi adicionado à sua lista de calendários com sucesso."
} else {
    Write-Host "O usuário $UsuarioCalendario não tem um calendário acessível ou você não tem permissões para acessá-lo."
}
