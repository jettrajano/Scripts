$SMTP = "smtp.office365.com"
$From = "vegeto@office365.com"
$To = "goku@dbz.com"
$Subject = "Test Subject"
$Body = "This is a test message"
$Email = New-Object Net.Mail.SmtpClient($SMTP, 587)
$Email.EnableSsl = $true
$Email.Credentials = New-Object System.Net.NetworkCredential("vegeto@office365.com", "password123qwe");
$Email.Send($From, $To, $Subject, $Body)