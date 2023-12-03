#####################################################################################
###         Cria vários diretorios e com diversos nomes a partir de um CSV        ###
#####################################################################################

# Criar um .csv com os diretorios a serem criados
# A primeira linha deverá ser o titulo e será usado na string
# OBS.: Os diretorios de destino deverão existir. Caso contrario, sera necessario utilizar outro script  

Import-Csv C:\Temp\Clientes\teste3.csv | % { New-Item -ItemType directory "C:\Temp\Clientes\$($_.path)" }
