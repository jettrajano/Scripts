$arrApprovedApplications = @("Anydesk")
$booApprovedApplications = $false

function Get-InstalledApps {
    if (![Environment]::Is64BitProcess) {
        $arrRegistryPaths = @('HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*'
                              'HKCU:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*')
    }
    else {
        $arrRegistryPaths = @('HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*'
                              'HKCU:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*'
                              'HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*'
                              'HKCU:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*')
    }

    $arrUninstallRegistrations = @()
    foreach ($registryPath in $arrRegistryPaths) {
        if (Test-Path $registryPath) {
            $arrUninstallRegistrations += Get-ItemProperty $registryPath
        }
    }

    $arrInstalledApps = @()
    foreach ($uninstallRegistration in $arrUninstallRegistrations) {
        if ($uninstallRegistration.DisplayName -ne $null) {
            $arrInstalledApps += $uninstallRegistration.DisplayName
        }
    }
    return $arrInstalledApps
}

$arrInstalledApplications = Get-InstalledApps
 foreach ($installedApplication in $arrInstalledApplications) {
    foreach ($ApprovedApplication in $arrApprovedApplications) {
        if ($installedApplication -eq $ApprovedApplication) {
            $booApprovedApplications = $true
        }
    }
}

if ($booApprovedApplications) {
    $appStatus = @{"Installation status" = "Approved app installed"}
} 
else {
    $appStatus = @{"Installation status" = "No Approved apps installed"}
}

return $appStatus | ConvertTo-Json -Compress 