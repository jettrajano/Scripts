## script em PowerShell para recuperar arquivos excluídos por um usuário específico em um site do SharePoint Online em um intervalo de tempo:
## Esse script usa o módulo PnP PowerShell para se conectar ao seu site do SharePoint Online e recuperar arquivos excluídos pelo usuário especificado em um intervalo de tempo especificado. 
## É importante que você preencha as informações de login e URL de site corretas antes de executar o script. 
## Além disso, você pode alterar o intervalo de tempo especificado nas variáveis $StartTime e $EndTime de acordo com suas necessidades.

# Connect to SharePoint Online
$Username = "user@tenant.onmicrosoft.com"
$Password = ConvertTo-SecureString "password" -AsPlainText -Force
$Credentials = New-Object System.Management.Automation.PSCredential($Username, $Password)
Connect-PnPOnline -Url https://tenant.sharepoint.com/sites/yoursite -Credentials $Credentials

# Define the user, site, and time frame to retrieve the deleted files from
$DeletedByUser = "user@tenant.onmicrosoft.com"
$SiteURL = "https://tenant.sharepoint.com/sites/yoursite"
$StartTime = (Get-Date).AddDays(-7)
$EndTime = (Get-Date)

# Get all deleted files for the defined user and time frame
$DeletedFiles = Get-PnPRecycleBinItem -Identity $SiteURL | where { $_.DeletedBy -eq $DeletedByUser -and $_.DeletedDate -ge $StartTime -and $_.DeletedDate -le $EndTime }

# Restore the deleted files
$DeletedFiles | Restore-PnPRecycleBinItem

# Disconnect from SharePoint Online
Disconnect-PnPOnline
