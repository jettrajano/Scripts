#####################################################################################
### Cria copia de um arquivo de origem em vários diretorios e com diversos nomes  ###
#####################################################################################

# Criar um .csv com os diretorios de destino e nomes definitivos (separados por virgula)
# A primeira linha deverá ser o titulo e será usado na string
# OBS.: Os diretorios de destino deverão existir. Caso contrario, sera necessario utilizar outro script  

Import-Csv C:\Temp\Clientes\teste2.csv | % { Copy-Item -Path C:\Temp\Clientes\arquivo.nrf -Destination "C:\Temp\Clientes\$($_.path)\$($_.file)" }
