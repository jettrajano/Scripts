Connect-PnPOnline -Url "https://bbmoadv.sharepoint.com" -DeviceLogin -LaunchBrowser

Import-Module "C:\temp\RecycleRestore.ps1" -force
Restore-RecycleBin -siteUrl https://bbmoadv.sharepoint.com/sites/BBMOADV -newerdate '6/16/2022 23:59' -olderDate '6/16/2022 00:0' -delEmail tributario@bbmo.adv.br -maxRows 100000
