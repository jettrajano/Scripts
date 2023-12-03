Import-module ActiveDirectory
Import-Csv .\SMTPLIST.csv | ForEach-Object
{
$username = $_.samaccountname
$userproxy = $_.emailaddress -split ';'
Set-ADUser -Identity $username -Add @{proxyAddresses= $userproxy}
}