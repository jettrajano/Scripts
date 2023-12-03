Import-Module ActiveDirectory
# Set the new password
$newPassword = ConvertTo-SecureString -AsPlainText "D1g1t@ll" -Force
Set-ADAccountPassword -Identity Smith -NewPassword $newPassword -Reset

Import-Module ActiveDirectory
$newPassword = ConvertTo-SecureString -AsPlainText "D1g1t@ll" -Force
Get-ADUser -LDAPfilter '(name=*)'`
  -SearchBase "OU=Novos Usuarios,DC=arqdigital,DC=com,DC=br" | Set-ADAccountPassword  -NewPassword $newPassword -Reset