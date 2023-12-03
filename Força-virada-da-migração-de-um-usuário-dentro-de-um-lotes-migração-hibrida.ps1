## Abra uma janela do Powershell ISE como Administrador para poder rodar os comandos abaixo.
##Rode esse comando para liberar a execução de usuário remoto na sessão de usuário ativa
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser

##Rode para ativar o modulo do Serviços do Microsoft Online após finalização do PSGallery
Install-Module MSOnline
##Rode para ativar o modulo do Exchange Online v2 pós finalização do PSGallery
Install-Module -Name ExchangeOnlineManagement

#Exchange Online é preciso logar com uma conta com permissões de global admin ou Exchange admin.
Import-Module ExchangeOnlineManagement
Connect-ExchangeOnline -ShowProgress $true

## Força a virada do lado do Exchange Online via powershell - preciso adicionar o horário correto e com ao menos 5 minutos do horário que está rodando o comando
Set-MigrationUser -Identity maria.silva@bib.com.br -CompleteAfter "2/10/2023 11:40 AM"

## Pega o status da execução usuário no Lote e o resultado do comando acima.
Get-MigrationUser -Identity maria.silva@bib.com.br