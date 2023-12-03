#faz uma varredura nos discos dos servidores pra identifcar ip hardcode em arquivos que vc especificar para buscar e gera um relatório

#ATRIBUO O SERVIDOR CORRENTE A VARIÁVEL $SERVIDOR
$servidor =  get-content env:computername

#VERIFICO TODOS OS VOLUMES DE DISCOS LOCAIS DO SERVIDOR CORRENTE
$volumesServers = Get-WmiObject Win32_LogicalDisk -ComputerName $servidor | select -ExpandProperty DeviceID

$volumesServersMapped = Get-WmiObject Win32_MappedLogicalDisk -ComputerName $servidor | select -ExpandProperty DeviceID 

#REMOVO OS VOLUMOES MAPEADOS E MANTENHO APENAS DISCOS LOCAIS
$volumesServers = $volumesServers | Where-Object { $volumesServersMapped -notcontains $_ }


$FilesOfInterest = ( "*.txt"
	#"*.ini","*.config","*.properties","*.bat","*.cmd","*.ps1",
	#"*.psm1","*.hta","*.vbs","*.wsf","*.xml","*.cfg","*.json","*.prefs",
	#"*.url","sqlnet.*", "tnsnames.*", "*.ora"
)

$pattern = "(192)\.(168)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)|(172)\.(16)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)|(10)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)"
#"(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)"
# Simplier regex (172\.\d+\.\d+\.\d+)
foreach ($discos in $volumesServers){


function FindFilesWithContent($Input_Path, $Include, $Pattern){
	# recursively search for all files match the $searchExtensions list;
	# force the search and suppress standard access errors.
#Where-Object {$_.PSParentPath -notlike "*Program Files*" -and $_.PSParentPath -notlike "*Users*" -and $_.PSParentPath -notlike "*Windows*"}
	try{
        $input_path =  "$discos\"
		Get-ChildItem -Path:$input_path -Include:$Include `
			-Recurse -Force -ErrorAction:SilentlyContinue |
			?{!$_.PSIsContainer} | Where-Object {$_.PSParentPath -notlike "*temp*" -and $_.PSParentPath -notlike "*Users*"} |
		ForEach-Object{
			#Write-Progress $_.FullName;
			$item = $_;
			Get-Content $_ -ErrorAction SilentlyContinue |
			ForEach-Object {
				if($_ -match $Pattern){
					
					"" | select filename,match | %{
						$_.filename = $item.FullName;
						$_.match = $matches[0]; #fill value
						return $_ #emit it to pipeline
					}
				}
	
			}
		}
	}
	catch{
		
	}
}

                                                                                                            
$filesremoved = FindFilesWithContent -Root $env:homedrive\$env:homepath -Include $FilesOfInterest -Pattern $pattern 
 
                                                                                                                                                                                #CAMINHO DE REDE AQUI, ENTRE \\ E O NOME DO ARQUIVO       
$filesremoved | Select-Object -Property filename, match | ConvertTo-Csv -Delimiter ","  -NoTypeInformation | Select-Object -Skip 1 | Out-File -Append -Encoding ascii -FilePath "D:\Log\$servidor.CSV"

}
