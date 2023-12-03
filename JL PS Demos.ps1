################################################################################################################################################
## Artigo que explica como conectar com vários serviços do O365 numa única janela de PS
## https://docs.microsoft.com/en-us/office365/enterprise/powershell/connect-to-all-office-365-services-in-a-single-windows-powershell-window
##
## Artigo que explica como instalar o modulos de PS
## https://docs.microsoft.com/en-us/office365/enterprise/powershell/connect-to-office-365-powershell##connect-with-the-azure-active-directory-powershell-for-graph-module

## Connect with the Azure Active Directory PowerShell for Graph module
## Somente é preciso fazer isto uma vez
Install-Module -Name AzureAD
Connect-AzureAD

## Connect with the Microsoft Azure Active Directory Module for Windows PowerShell
## Somente é preciso fazer isto uma vez
Install-Module MSOnline
Import-Module MsOnline

## Conecta com Azure Active Directory for PS e mostra os domínios
$credential = Get-Credential
Connect-MsolService -Credential $credential
Get-MsolDomain

## Conecta com Exchange Online
## https://docs.microsoft.com/en-us/powershell/exchange/exchange-online/connect-to-exchange-online-powershell/mfa-connect-to-exchange-online-powershell?view=exchange-ps
$exchangeSession = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri "https://outlook.office365.com/powershell-liveid/" -Credential $credential -Authentication "Basic" -AllowRedirection
Import-PSSession $exchangeSession -DisableNameChecking
Get-AcceptedDomain

## Conecta com Exchange Online MFA
## Instala o módulo antes como descrito => https://docs.microsoft.com/en-us/powershell/exchange/exchange-online/connect-to-exchange-online-powershell/mfa-connect-to-exchange-online-powershell?view=exchange-ps
## On your local computer, open the Exchange Online Remote PowerShell Module ( Microsoft Corporation > Microsoft Exchange Online Remote PowerShell Module).
Connect-EXOPSSession -UserPrincipalName gustavo_freire@praxair.com
Get-PSSession | Remove-PSSession

## Conecta com o Sharepoint Online PS e mostra os Sites
Import-Module Microsoft.Online.SharePoint.PowerShell -DisableNameChecking
Connect-SPOService -Url https://groupnetltda-admin.sharepoint.com -credential $credential
Get-SPOSite

## Conecta no Skype for Business Online
Import-Module SkypeOnlineConnector
$sfboSession = New-CsOnlineSession -Credential $credential
Import-PSSession $sfboSession


## Conecta Security & Compliance Center e adiciona a string `cc´ como prefixo do comando Get-RoleGroup vira Get-ccRoleGroup, para evitar mesmo comando já registado pelo Exchange
$ccSession = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://ps.compliance.protection.outlook.com/powershell-liveid/ -Credential $credential -Authentication Basic -AllowRedirection
Import-PSSession $ccSession -Prefix cc


## Fechando as seções PS do Skype, Exchange e Sec Compliance Center
Get-PSSession
Remove-PSSession $sfboSession
Remove-PSSession $exchangeSession
Remove-PSSession $ccSession
## ou todos numa linha Get-PSSession | Remove-PSSession
Disconnect-SPOService
## Para o MSonline pode simplesmente fechar a janela do PS

################################################################################################################################################

# Mostra os serviços da Licença E3
Get-MsolAccountSku | Where-Object {$_.SkuPartNumber -eq 'ENTERPRISEPACK'} | ForEach-Object {$_.ServiceStatus}

# Mostra os usuários de determinada Licença
Get-MsolUser -MaxResults 10000 | Where-Object {($_.licenses).AccountSkuId -match "EMS"} 

# Mostra usuários sem licença
Get-MsolUser -UnlicensedUsersOnly

# Mostra a versão do módulo PowerSHellGer responsável por baixar módulos do repositório
Get-Module PowerShellGet -list | Select-Object Name,Version,Path

## Lista o Object ID de um security grupo que tenha essa string 
Get-MsolGroup -SearchString O365MailUsers

## Adiciona um user num grupo do tipo DL, tem q usar Exchange Module
Add-DistributionGroupMember -Identity "O365MailUsers" -Member "demo2.user2@teste.fink.com.br"

## Lista os membros do grupo DL
Get-DistributionGroupMember -Identity "UsuariosMigrados"
Get-DistributionGroupMember -Identity "import"

####################################################################################
# https://gallery.technet.microsoft.com/office/List-all-Users-Distribution-7f2013b2

## List all Distribution Groups and their Membership in Office 365

#Get members of this group  
    $objDGMembers = Get-DistributionGroupMember -Identity $($objDistributionGroup.PrimarySmtpAddress)  
      
    write-host "Found $($objDGMembers.Count) members..."  
      
    #Iterate through each member  
    Foreach ($objMember in $objDGMembers)  
    {  
        Out-File -FilePath $OutputFile -InputObject "$($objDistributionGroup.DisplayName),$($objDistributionGroup.PrimarySMTPAddress),$($objMember.DisplayName),$($objMember.PrimarySMTPAddress),$($objMember.RecipientType)" -Encoding UTF8 -append  
        write-host "`t$($objDistributionGroup.DisplayName),$($objDistributionGroup.PrimarySMTPAddress),$($objMember.DisplayName),$($objMember.PrimarySMTPAddress),$($objMember.RecipientType)" 
    }  



#####################################################################################
### Adiciona usuários num grupo A PARTIR DE CSV                                   ###
#####################################################################################


$pathlista = "C:\fapes\onda33.txt"
$lista = Import-Csv $pathlista -Delimiter ";"
$cont = 1

foreach($item in $lista){
	#cria as variáveis com base no csv
	$identity = $item.email

	#imprime na tela o andamento
	Write-Host($cont,"-",$identity)
	$cont ++
	Add-DistributionGroupMember -Identity "UsuariosMigrados" -Member $identity
}



##########################################################################################

#####################################################################################
### CRIA novos grupos DL A PARTIR DE CSV                                            ###
#####################################################################################


$pathlista = "C:\fapes\listateste.csv"
$lista = Import-Csv $pathlista -Delimiter ";"
$cont = 1

foreach($item in $lista){
	#cria as variáveis com base no csv
	$identity = $item.email
    $name = $item.name
    $members = $item.file
   
    
	#imprime na tela o andamento
	Write-Host($cont,"=>",$identity ,"=>", $name )
	$cont ++
	New-DistributionGroup -Name "$name" -PrimarySmtpAddress $identity

}

##########################################################################################

#####################################################################################
### ADICIONA MEMBROS A GRUPOS JA EXISTENTES A PARTIR DE UM ARQUIVO CSV            ###
#####################################################################################

$pathlista = "C:\fapes\listateste.csv"
$lista = Import-Csv $pathlista -Delimiter ";"
$cont = 1

foreach($item in $lista){
	#cria as variáveis com base no csv
	$identity = $item.email
    $name = $item.name
    $file = $item.file
   
    
	#imprime na tela o andamento
	Write-Host($cont,"=>",$identity ,"=>", $name ,"=>", $file )
	$cont ++
	

    $grupo = Import-Csv $file -Delimiter ";"
    $contb = 1
    
    foreach($item in $grupo) {
        $membros = $item.membros
        Write-Host($contb,"=>",$membros )
        Add-DistributionGroupMember -Identity $identity -Member $membros
	    $contb ++
    }



}





#####################################################################################
### Mudar timezone e language das caixas de correios e calendário A PARTIR DE CSV ###
#####################################################################################


$language = "pt-BR"
$timezone = "E. South America Standard Time"

$pathlista = "C:\fapes\onda33.txt "
$lista = Import-Csv $pathlista -Delimiter ";"
$cont = 1

foreach($item in $lista){
	#cria as variáveis com base no csv
	$identity = $item.email

	#imprime na tela o andamento
	Write-Host($cont,"-",$identity)
	$cont ++
	Get-mailbox $identity | Set-MailboxRegionalConfiguration -TimeZone $timezone –Language $language -LocalizeDefaultFolderName
	Get-mailbox $identity | Set-MailboxCalendarConfiguration -WorkingHoursTimeZone $timezone
	
}



## Configura uma determinada caixa postal
Set-MailboxRegionalConfiguration -Identity tbueno@fink.com.br -Language pt-BR -LocalizeDefaultFolderName -TimeZone "E. South America Standard Time"
Set-MailboxCalendarConfiguration -Identity laura@podiumlogistics.com.br -WorkingHoursTimeZone "E. South America Standard Time"
## Consulta
Get-MailboxRegionalConfiguration -identity esousa@fink.com.br
Get-MailboxCalendarConfiguration -identity esousa@fink.com.br
##########################################################################################

#########################################################################################
### Consultar timezone e language das caixas de correios e calendário A PARTIR DE CSV ###
#########################################################################################

$language = "pt-BR"
$timezone = "E. South America Standard Time"

#prepara o arquivo base de grupos
$pathlista = "C:\fapes\onda33.txt"
$lista = Import-Csv $pathlista -Delimiter ";"
$cont = 1

foreach($item in $lista){
	#cria as variáveis com base no csv
	$identity = $item.email

	#imprime na tela o andamento
	Write-Host($cont,"-",$identity)
	$cont ++
	Get-MailboxRegionalConfiguration -identity $identity
	Get-MailboxCalendarConfiguration -identity $identity
}


##########################################################

##########################################
### Atribuir a Localidade BR de um CSV ###
##########################################

#prepara o arquivo base de grupos
$pathlista = "C:\Meu\Mig\lista.csv"
$lista = Import-Csv $pathlista -Delimiter ";"
$cont = 1

foreach($item in $lista){
	#cria as variáveis com base no csv
	$identity = $item.email

	#imprime na tela o andamento
	Write-Host($cont,"-",$identity)
	$cont ++

	Set-MsolUser -UserPrincipalName $identity -UsageLocation "BR"
}

################################################################

##############################################
### Consulta a Localidade de uma lista CSV ###
##############################################

#prepara o arquivo base de grupos
$pathlista = "C:\Meu\Mig\lista.csv"
$lista = Import-Csv $pathlista -Delimiter ";"
$cont = 1

foreach($item in $lista){
	#cria as variáveis com base no csv
	$identity = $item.email

	#imprime na tela o andamento
	Write-Host($cont,"-",$identity)
	$cont ++

	Get-MsolUser -UserPrincipalName $identity | Select-Object UsageLocation
}

Get-MsolUser -UserPrincipalName lganon@fink.com.br | Select-Object UsageLocation

##########################################################

#prepara o arquivo base de grupos
$pathlista = "C:\fapes\onda33.txt"
$lista = Import-Csv $pathlista -Delimiter ";"
$cont = 1

foreach($item in $lista){
	#cria as variáveis com base no csv
	$identity = $item.email

	#imprime na tela o andamento
	Write-Host($cont,"-",$identity)
	$cont ++
	Add-MailboxFolderPermission -Identity $identity -User “groupnet.joao.labre@fapes.com.br” -AccessRights Owner
}


## The results are sorted by mailbox size from largest to smallest, and they are exported to a CSV file
Get-Mailbox -ResultSize Unlimited | Get-MailboxStatistics | Select DisplayName,StorageLimitStatus,@{name="TotalItemSize (MB)";expression={[math]::Round((($_.TotalItemSize.Value.ToString()).Split("(")[1].Split(" ")[0].Replace(",","")/1MB),2)}},@{name="TotalDeletedItemSize (MB)";expression={[math]::Round((($_.TotalDeletedItemSize.Value.ToString()).Split("(")[1].Split(" ")[0].Replace(",","")/1MB),2)}},ItemCount,DeletedItemCount | Sort "TotalItemSize (MB)" -Descending | Export-CSV "C:\Users\jlabre\Desktop\Fink_Onda2.csv" -NoTypeInformation


Get-MsolUser -SearchString braerhz1 | Select-Object UserPrincipalName, DisplayName, Licenses, LastDirSyncTime, Department, UsageLocation, AlternateEmailAddresses

## Mostra propriedades do usuário informado pelo UPN

Get-MsolUser -UserPrincipalName kEYLLA_DELL@praxair.com | Select-Object UserPrincipalName, DisplayName, sAMAccountName, mailNickName, Email, Licenses, LastDirSyncTime, Department, UsageLocation, AlternateEmailAddresses, extensionAttribute1, extensionAttribute2, extensionAttribute3, extensionAttribute4, extensionAttribute5, targetAddress, proxyAddresses, co


Get-MsolUser -UserPrincipalName alvaro_vargas@praxair.com | Select-Object *
