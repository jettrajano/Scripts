$SMTP = "smtp.sendgrid.net"
$From = "senior@gricki.com.br"
$To = "victor@gricki.com.br"
$Subject = "Test Subject envio pelo send grid via powershell"
$Body = "This is a test message"
#$Attachments = "C:\temp\Teste.txt"
$Email = New-Object Net.Mail.SmtpClient($SMTP, 587)
$Email.EnableSsl = $true
$Email.Credentials = New-Object System.Net.NetworkCredential("senior@gricki.com.br", "fVq2hIxgBYA.AqQZjVQNSMb6F2JcL3u1rjIaBf0aj28bR0ujvQc5SUk");
$Email.Send($From, $To, $Subject, $Body, $Attachments)