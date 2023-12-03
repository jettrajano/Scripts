#################################################################################
#
#   Script para mover os usuários listado no CSV entre OU's
#
#################################################################################
Import-Module ActiveDirectory

$TargetOU = "CN=Users,DC=forship,DC=com,DC=br"

Import-CSV C:\temp\MoverUsers.csv | ForEach-Object {
   
    $UserDN = (Get-ADUser -Identity $_.samaccountname).distinguishedName

    Move-ADObject -Identity $UserDN -TargetPath $TargetOU

} 
