# Connect to SharePoint Online
$Username = "user@tenant.onmicrosoft.com"
$Password = ConvertTo-SecureString "password" -AsPlainText -Force
$Credentials = New-Object System.Management.Automation.PSCredential($Username, $Password)
Connect-PnPOnline -Url https://tenant.sharepoint.com/sites/yoursite -Credentials $Credentials

# Define the user and site to retrieve the deleted files from
$DeletedByUser = "user@tenant.onmicrosoft.com"
$SiteURL = "https://tenant.sharepoint.com/sites/yoursite"

# Get all deleted files for the defined user
$DeletedFiles = Get-PnPRecycleBinItem -Identity $SiteURL | where { $_.DeletedBy -eq $DeletedByUser }

# Restore the deleted files
$DeletedFiles | Restore-PnPRecycleBinItem

# Disconnect from SharePoint Online
Disconnect-PnPOnline
