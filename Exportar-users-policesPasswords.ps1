## 1. Install Microsoft Graph PowerShell
## Before you run the Export-M365PasswordReport.ps1 PowerShell script, you need to install the Microsoft Graph PowerShell module.
## Run the below command to install the Microsoft Graph module.
Install-Module Microsoft.Graph -Force

##Connect to Microsoft Graph PowerShell
## You need to connect to MS Graph with the below scopes
Connect-MgGraph -Scopes "User.ReadWrite.All", "Group.ReadWrite.All", "Directory.ReadWrite.All"

<#
    .SYNOPSIS
    .\Export-M365UsersPassword.ps1

    .DESCRIPTION
    Connect to Microsoft Graph PowerShell first.
    The script exports the passwords report for all Microsoft 365 users to a CSV file.

    .LINK
    Export Microsoft 365 users password report

    .NOTES
    Written By: o365info
    Website:    o365info.com

    .CHANGELOG
    V1.00, 10/26/2023 - Initial version
#>

# Get all domain password expiration policies
$domains = Get-MgDomain | Select-Object Id, PasswordValidityPeriodInDays
$domains | ForEach-Object { if (!$_.PasswordValidityPeriodInDays) { $_.PasswordValidityPeriodInDays = 90 } }

# Get user information 
$properties = "Id", "UserPrincipalName", "mail", "displayName", "PasswordPolicies", "LastPasswordChangeDateTime", "CreatedDateTime"
$users = Get-MgUser -Filter "userType eq 'member' and accountEnabled eq true" `
    -Property $properties -CountVariable userCount `
    -ConsistencyLevel Eventual -All -Verbose | `
    Select-Object $properties | Where-Object {
    "$(($_.userPrincipalName).Split('@')[1])" -in $($domains.id)
}

# Add properties to the $users objects
$users | Add-Member -MemberType NoteProperty -Name Domain -Value $null
$users | Add-Member -MemberType NoteProperty -Name MaxPasswordAge -Value 0
$users | Add-Member -MemberType NoteProperty -Name PasswordAge -Value 0
$users | Add-Member -MemberType NoteProperty -Name ExpiresOn -Value (Get-Date '1970-01-01')
$users | Add-Member -MemberType NoteProperty -Name DaysRemaining -Value 0

# Get the current datetime for calculation
$timeNow = Get-Date

foreach ($user in $users) {
    # Get the user's domain
    $userDomain = ($user.userPrincipalName).Split('@')[1]

    # Check if the user has "disablepasswordexpiration" set
    if ($user.PasswordPolicies -contains "DisablePasswordExpiration") {
        # Set values to indicate that the password does not expire for this user
        $passwordAge = (New-TimeSpan -Start $user.LastPasswordChangeDateTime -End $timeNow).Days
        $user.MaxPasswordAge = "Password does not expire"
        $user.PasswordAge = $passwordAge
        $user.ExpiresOn = "N/A"
        $user.DaysRemaining = "N/A"
    }
    else {
        # Get the maximum password age based on the domain password policy
        $maxPasswordAge = ($domains | Where-Object { $_.id -eq $userDomain }).PasswordValidityPeriodInDays

        # Check if MaxPasswordAge is 2147483647
        if ($maxPasswordAge -eq 2147483647) {
            $passwordAge = (New-TimeSpan -Start $user.LastPasswordChangeDateTime -End $timeNow).Days
            $user.MaxPasswordAge = "Password does not expire"
            $user.PasswordAge = $passwordAge
            $user.ExpiresOn = "N/A"
            $user.DaysRemaining = "N/A"
        }
        else {
            $passwordAge = (New-TimeSpan -Start $user.LastPasswordChangeDateTime -End $timeNow).Days
            $expiresOn = (Get-Date $user.LastPasswordChangeDateTime).AddDays($maxPasswordAge)
            $user.PasswordAge = $passwordAge
            $user.ExpiresOn = $expiresOn
            $user.DaysRemaining = $(
                # If the remaining days is negative, show "Expired" instead
                if (($daysRemaining = (New-TimeSpan -Start $timeNow -End $expiresOn).Days) -le 0) { "Expired" }
                else { $daysRemaining }
            )
            $user.MaxPasswordAge = $maxPasswordAge
        }
    }

    $user.Domain = $userDomain
}

# Display the results in Out-GridView
$users | Out-GridView

# Export the results to CSV file
$users | Export-Csv -Path "C:\temp\M365UsersPassword.csv" -NoTypeInformation -Encoding UTF8