Import-Module ActiveDirectory 
ForEach ($Item in (Get-Content C:\scripts\office365\grupos\aaattt.txt)){ 
    Get-ADUser -Filter ‘Name -eq $Item’ | Add-ADPrincipalGroupMembership -MemberOf "UPN do usuário a ser adicoinado"

}