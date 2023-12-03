$arrApprovedApplications = @("Anydesk", "Google", "OpenVPN")
$appStatus = @{}

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
foreach ($ApprovedApplication in $arrUnapprovedApplications) {
    if ($arrInstalledApplications -contains $ApprovedApplication) {
        $appStatus[$ApprovedApplication] = "Installed"
    }
    else {
        $appStatus[$ApprovedApplication] = "Not Installed"
    }
}

return $appStatus | ConvertTo-Json -Compress
