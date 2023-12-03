$arrUnapprovedApplications = @("Anydesk", "Google", "OpenVPN")
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
foreach ($unApprovedApplication in $arrUnapprovedApplications) {
    if ($arrInstalledApplications -contains $unApprovedApplication) {
        $appStatus[$unApprovedApplication] = "Installed"
    }
    else {
        $appStatus[$unApprovedApplication] = "Not Installed"
    }
}

return $appStatus | ConvertTo-Json -Compress
