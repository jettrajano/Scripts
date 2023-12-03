# Input bindings are passed in via param block.
param($Timer)

# Get the current universal time in the default string format.
$currentUTCtime = (Get-Date).ToUniversalTime()

# The 'IsPastDue' property is 'true' when the current function invocation is later than scheduled.
if ($Timer.IsPastDue) {
    Write-Host "PowerShell timer is running late!"
}

# Write an information log with the current time.
Write-Host "PowerShell timer trigger function ran! TIME: $currentUTCtime"
    
#Install-Module PowershellGet -Force -Scope CurrentUser    
#Install-Module -name Az -AllowClobber -Force -Scope CurrentUser
#Import-Module Az
#Install-Module Azure -Force -Scope CurrentUser
#Import-Module Az.Accounts
#Import-Module Az
#Connect-AzAccount


Write "Pegando variáveis"
$StorageAccountName = "stgadataprd4mreporthoras"
$resourceGroupName = "rg-prd-reporthoras"
$keyVaultName = "kv-reportHoras"
$secretNameBeebole = "BeeboleAPIChave"
$secretNameStorage = "ChaveStorageBeeboleAcess"
$ContainerName = "beeboleoutput"
    
#Get-Module

$Key2 = Get-AzKeyVaultSecret -VaultName $keyVaultName -Name $secretNameBeebole -AsPlainText

$Key1 = Get-AzKeyVaultSecret -VaultName $keyVaultName -Name $secretNameStorage -AsPlainText
Write "Obteve as secrets!###################>>>>>>>" + $key2


$StorageAccountKey = $Key1.Trim()
$secretBeeboleKey =  $key2.Trim()


#Pega URL da API
$Url = "https://803b433162432915ce2e7b25a022910925ab73c2:x@beebole-apps.com/api/v2"

#Configura o header com a chave gerada pelo beebole
$headers = @{               
    'Authorization' =  $secretBeeboleKey 
    'Content-Type' = 'application/json'
}

$arrayDias = "01","02","03","04","05"

#pego a data de um dia anterior ao dia corrente
$date = Get-Date (Get-Date).AddDays(-1) -format "yyyy-MM-dd"

#pego o ano corrente
$ano =  Get-Date -Format "yyyy"

#pego o mes corrente
$mes = Get-Date -Format "MM"

#pego o dia anterior
$dateDia = Get-Date (Get-Date).AddDays(-1) -format "dd"
$mesAlterado = "false"
$anoAlterado = "false"
#para cada dia do array, caso o dia corrente, seja um dos dias do array, o mes anterior é o que será carregado para o storage
foreach($primeirosDiasMes in $arrayDias){

if($dateDia -eq $primeirosDiasMes){
$mesCurrentAux = $mes
$mes = Get-Date (Get-Date).AddMonths(-1) -Format "MM"

    $mesAlterado = "true"

    #se o mes for 01, coloco o ano anterior na variável ano
    if($mesCurrentAux -eq "01"){

    $ano =  Get-Date (Get-Date).AddYears(-1) -Format "yyyy"
    $anoAlterado = "true"
    
    }

}

}

$dataInicial = $ano+"-"+$mes+"-"+"01"

$lastDay = [DateTime]::DaysInMonth($ano, $mes)

if($mesAlterado -eq "true"){

    $data = $ano+"-"+$mes+"-"+$lastDay

}else {

    $data = Get-Date (Get-Date).AddDays(-1) -format "yyyy-MM-dd"

}

#removo o arquivo antigo
$mesAnterior = Get-Date (Get-Date).AddMonths(-1) -Format "MM"
$anoAnterior = Get-Date (Get-Date).AddYears(-1) -Format "yyyy"
$mesExtensoAnterior = (Get-Culture).DateTimeFormat.GetMonthName($mesAnterior)
$segundoDiaMes = Get-Date (Get-Date) -format "dd"
if($segundoDiaMes -eq '08'){

    if ($anoAlterado -eq "true") {

        Remove-AzStorageBlob -Container "beeboleoutput" -Blob "BB-REPORT-$mesExtensoAnterior-$anoAnterior.csv"   
    }else {
        Remove-AzStorageBlob -Container "beeboleoutput" -Blob "BB-REPORT-$mesExtensoAnterior-$ano.csv"
    }

    }
Write "Removeu o arquivo antigo"

$dataInicial2 = '2021-10-01'
$data2 = '2021-10-31'

$mesExtenso = (Get-Culture).DateTimeFormat.GetMonthName($mes)

#Realizo a consulta especificada 
$bodyConsulta = @{
  service = "time_entry.export"
  from = $dataInicial    # REMOVER ESSAS DATAS MARRETADAS PARA PEGAR AS DATAS CORRETAS ACIMA
  to = $data             # REMOVER ESSAS DATAS MARRETADAS PARA PEGAR AS DATAS CORRETAS ACIMA
  show = "all" 
  keys = @('company', 'project', 'subproject','person', 'date', 'hours')
                  
     
  } | ConvertTo-Json

Do
{
#salvo id na variavel Id
$Id = Invoke-WebRequest -Uri $Url -Method Post -Headers $headers -Body $bodyConsulta | ConvertFrom-Json | select -expand job | Select id 
Wait-Event  -Timeout 8
#Monto o Json para a segunda requisição pegando o Id da requisição anterior
  $bodyResult = @{
  
  service = "time_entry.get_job_info"
  id =$Id
  #outputFormat = "array" 
 
  } | ConvertTo-Json


#Realizo a segunda requisição                                                                    
$consultaResult = Invoke-WebRequest -Uri $Url -Method Post -Headers $headers -Body $bodyResult
Wait-Event  -Timeout 8
#Salvo o CSV 
$file = $ConsultaResult | ConvertFrom-Json | select -expand job | select -expand result | Format-List | out-file -Encoding UTF8 -FilePath "C:\home\BB-REPORT-$mesExtenso-$ano.csv" 
$sourceFileRootDirectory = "C:\home\BB-REPORT-$mesExtenso-$ano.csv"

#Realizo a verificação do status, caso "done" o script é encerrado, senão refaz o processo
$verifica = $consultaResult | ConvertFrom-Json | select -expand job | select status



}while($verifica -eq "running")

$ctx = New-AzStorageContext -StorageAccountName $StorageAccountName -StorageAccountKey $StorageAccountKey
Set-AzStorageBlobContent -File $sourceFileRootDirectory -Container "beeboleoutput"  -Blob "BB-REPORT-$mesExtenso-$ano.csv" -Context $ctx -Force:$Force | Out-Null  
Write "Arquivo Salvo no storage!"




Remove-Item "C:\home\BB-REPORT-$mesExtenso-$ano.csv" -force


##>
