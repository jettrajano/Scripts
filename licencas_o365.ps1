Set-ExecutionPolicy RemoteSigned

$credential = Get-Credential
Connect-MsolService -Credential $credential
Get-MsolDomain

$exchangeSession = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri "https://outlook.office365.com/powershell-liveid/" (https://outlook.office365.com/powershell-liveid/%27) -Credential $credential -Authentication "Basic" -AllowRedirection
Import-PSSession $exchangeSession -DisableNameChecking
Get-AcceptedDomain

$pathlista = "C:\Temp\todoswhite.csv"
$lista = Import-Csv $pathlista #-Delimiter ","
$cont = 1

foreach($item in $lista){
	#cria as variáveis com base no csv
	$identity = $item.email

	#imprime na tela o andamento
	Write-Host($cont,"-",$identity)
	$cont ++

 ##### LINHA USADA PARA PEGAR OS 3 USUÁRIOS APENAS QUE A CARMINHA PEDIU ####
 #Get-MsolUser -UserPrincipalName franklin_guzman@praxair.com | Select-Object UserPrincipalName, Licenses, DisplayName,UsageLocation

 ##### LINHAS UTILIZADA PARA GERAR O CSV COM TODOS USUÁRIOS NO INPUT DO CSV ####
 Get-MsolUser -UserPrincipalName $identity  | 
 Select UserPrincipalName,@{n="Licenses Type";e={$_.Licenses.AccountSKUid}} | Export-Csv -Path C:\temp\White_Export_Lics_o365_07-01-2019.xls -NoTypeInformation -Append

 #Get-MsolUser -UnlicensedUsersOnly
}  

