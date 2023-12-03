


##  Ler todos atributos extendidos
Get-mailbox jlabre@4mstech.com | FL CustomAttribute*

## Altera o atributo 1 
Set-Mailbox gfreire@4mstech.com -CustomAttribute1 "jlabre@4mstech.com"

## Altera o atributo 1 e 2
Set-Mailbox gfreire@4mstech.com -CustomAttribute1 jlabre@4mstech.com -CustomAttribute2 FTE

## Altera o atributo 5 para todo mundo
Get-Mailbox | Set-Mailbox -CustomAttribute5 <the new value>

## Lista todos os atributos de um objeto
Get-Mailbox -Identity jlabre@4mstech.com | Select-Object *

