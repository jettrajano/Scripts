## Para corrigir erros de conexão entre do cliente PowerShell aos modulos do Exchange Online após atualização de configurações de MFA no tenant ou por falha de configuração WIMRM
## Rode os comandos abaixo:
## Abra o Powershell como Admin.
## Caso seja preciso instalar os modulos de NuGet rode abaixo
    Install-PackageProvider -Name NuGet -Force
    ## Caso ocorra erros realize a istalação com comando forçado.
    Install-Module PowerShellGet -AllowClobber -Force

## Definir a politica de execução como remota
    Set-ExecutionPolicy RemoteSigned

## Coletar o status da configuração do WinRM
    winrm get winrm/config/client/auth

## Definir protocolo de rede padrão [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
    [Net.ServicePointManager]::SecurityProtocol = [Net.ServicePointManager]::SecurityProtocol -bor [Net.SecurityProtocolType]::Tls12

## Comando para Redefinir a variavel de ambiente do cliente WimRM local na máquina é temporário ao reiniciar volta para o valor "0"
    Set-ItemProperty -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\WinRM\Client' -Name 'AllowBasic' -Type DWord -Value '1'

## Commando para reconfigurar as definições do WinRM para trabalhar com basic autentication local na máquina é temporário ao reiniciar volta para o valor "0"
    winrm set winrm/config/client/auth '@{Basic="true"}'

## Validar qual a politica está atribuida ao usuário
    Get-User -Identity <UserIdentity> | Format-List RemotePowerShellEnabled

## Ativar e definir permissão de execução no PS remoto
    Set-User -Identity <UserIdentity> -RemotePowerShellEnabled $true