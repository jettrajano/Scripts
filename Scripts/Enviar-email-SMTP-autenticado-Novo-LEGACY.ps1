﻿## Novo
$mycredentials = Get-Credential
Send-MailMessage -SmtpServer smtp.office365.com -Port 587 -UseSsl -From compras@cbccouros.com.br -To compras@cbccouros.com.br -Cc tadeu@sou.cloud -Subject 'Teste de envio Smtp' -Body 'Teste feito para disparo smptp' -Credential $mycredentials -Attachments "C:\temp\teste.png"

## Legado
$mycredentials = Get-Credential
Send-MailMessage -SmtpServer smtp-legacy.office365.com -Port 587 -UseSsl -From compras@cbccouros.com.br -To compras@cbccouros.com.br -Cc tadeu@sou.cloud -Subject 'Teste de envio Smtp' -Body 'Teste feito para disparo smptp' -Credential $mycredentials -Attachments "C:\temp\teste.png"
