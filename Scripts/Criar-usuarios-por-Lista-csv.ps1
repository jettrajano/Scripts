﻿#cria contas e atribui licença Office 365 Enterprise E3 com base em arquivo CSV#
Connect-MsolService
Import-Csv -Path "C:\temp\Input-UsersCreate.csv" | foreach {New-MsolUser -DisplayName $_.DisplayName -FirstName $_.FirstName -LastName $_.LastName -UserPrincipalName $_.UserPrincipalName -UsageLocation $_.UsageLocation -LicenseAssignment $_.AccountSkuId} | Export-Csv -Path "C:\temp\Output-UsersCreate.csv.csv"