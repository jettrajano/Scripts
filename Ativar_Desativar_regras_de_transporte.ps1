#Desativar regra de transporte adicionar o nome da regra entre as aspas duplas. Regra será desativa sem pop-up de confirmação
Disable-TransportRule "Entrega comunicados apenas ao Hapvida.com.br" -Confirm:$false
#Ativar regra de transporte adicionar o nome da regra entre as aspas duplas. Regra será ativada sem pop-up de confirmação
enable-TransportRule "Entrega comunicados apenas ao Hapvida.com.br" -Confirm:$false
#Pega as regras de Transporte no tenant.
Get-TransportRule
