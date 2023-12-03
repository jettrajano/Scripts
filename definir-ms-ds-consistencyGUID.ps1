 Set-AzureAdUser -ObjectId milka.rabelo@arqdigital.com.br -ImmutableId T/wHBQRhqUCNd+mYOJTS/A==

 $Filepath = $env:userprofile\desktop\file.csv
$csv = Import-Csv -Path $filepath
$immutableID=$null
 
Foreach($user in $csv)
{
Set-MsolUser -UserPrincipalName $user.UserPrincipalName -ImmutableID $immutableID
}
