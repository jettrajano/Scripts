Import-Module ActiveDirectory
$ErrorActionPreference = "Stop"


#$pdcName = "usadandc2.na.praxair.com"
$pdcName = "bradandc01.sa.praxair.com";
#$pdcName = "chndandfb1.as.praxair.com";
#$pdcName = "usadandc01.corp.praxair.com";
#$pdcName = "pstidandc1.psti.praxair.com";
#$pdcName = "eurdandc5.eu.praxair.com";
#$pdcName = "bnldandc1.bnl.eu.praxair.com";
#$pdcName = "deudandc01.de.eu.praxair.com";
#$pdcName = "espdandc1.esp.eu.praxair.com";
#$pdcName = "itldandc1.rs.itl.eu.praxair.com";
#$pdcName = "nldamsdcitl02.itl.eu.praxair.com";
#$pdcName = "rusdandc1.rus.eu.praxair.com"

#$microsoftMailDomain = "praxair.onmicrosoft.com"          # for PSTI
$microsoftMailDomain = "praxair.mail.onmicrosoft.com"      # for everyone else

$notesMailDomain = "notes.praxair.com"

$notesLdapConn = New-Object -com "ADODB.Connection"
$notesLdapConn.Provider = "ADsDSOObject"
$notesLdapConn.Open("Active Directory Provider")


function Get-O365MigrationStatus {
    param(
        [Parameter(Mandatory=$true)]
        [string]$mailLocalpart,        # ex. brian_donorfio

        [Parameter(Mandatory=$true)]
        [string]$mailDomain,           # either "praxair.mail.onmicrosoft.com" or "praxair.onmicrosoft.com"

        [Parameter(Mandatory=$true)]
        [PSObject]$notesLdapConn       # ADODB.Connection object to Notes
    )

    process {
        $notesLdapServer = "usadannsdir01.na.praxair.com"
        $notesSearchBase = "O=Praxair"

        $query = ("SELECT * FROM 'LDAP://{0}/{1}' WHERE objectClass='person' AND MailAddress='{2}@{3}'" -f $notesLdapServer,$notesSearchBase,$mailLocalpart.Replace("'","''"),$mailDomain)
        $rst = $notesLdapConn.Execute($query)
        
        $retval = $rst.RecordCount -eq 1
        $rst.Close()
        return $retval
    }
}

function Repair-ProxyAddressesAttribute {
    param(
        [Parameter(Mandatory=$true)]
        [Microsoft.ActiveDirectory.Management.ADUser]$user,    # user object from Get-ADUser with all expected properties, same as Repair-O365Attributes

        [Parameter(Mandatory=$true)]
        [System.Array]$smtpAddresses,                          # expected like @("SMTP:fn_ln@praxair.com","smtp:fn_ln@praxair.mail.onmicrosoft.com", "smtp:fn_ln@praxair.onmicrosoft.com")

        [bool]$removePxMsSmtp = $false,                        # toggle to remove O365 addresses

        [bool]$removeOtherSmtp = $true,                        # toggle to remove other (non-O365 / non-PX) addresses

        [bool]$removeOtherNonSmtp = $false                     # toggle to remove non-smtp (x500?) addresses
    )

    process {
        [Collections.Generic.List[String]]$paList = @()
        $user.proxyAddresses | %{ $paList.Add($_) }
        for ($i=0; $i -lt $paList.Count; $i++) {
            if ($paList[$i].Substring(0,5) -eq "SMTP:" -and $paList[$i].Substring(0,5) -cne "SMTP:" -and $paList[$i].Substring(0,5) -cne "smtp:") {
                # fix mixed case smtp by defaulting to lower
                $paList[$i] = ("smtp:{0}" -f $paList[$i].Substring(5))
            }

            if ($paList[$i].Substring(0,5) -eq "SMTP:") {
                # SMTP or smtp
                $found = $false
                for ($j = 0; $j -lt $smtpAddresses.Count; $j++) {
                    if ($paList[$i].Substring(0,5) -ceq $smtpAddresses[$j].Substring(0,5) -and $paList[$i].Substring(5) -eq $smtpAddresses[$j].Substring(5)) {
                        # match smtp case + email address
                        $found = $true
                        break
                    }
                }
                if ($found -eq $false) {
                    if ($removeOtherSmtp) {
                        $paList.RemoveAt($i)
                        $i--
                    }
                }
            }
            else {
                # other non-SMTP
                if ($paList[$i].ToLower().Contains("praxair.mail.onmicrosoft.com") -or $paList[$i].ToLower().Contains("praxair.onmicrosoft.com")) {
                    if ($removePxMsSmtp) {
                        $paList.RemoveAt($i)
                        $i--
                    }
                }
                elseif ($removeOtherNonSmtp) {
                    $paList.RemoveAt($i)
                    $i--
                }
            }
        }

        for ($i = 0; $i -lt $smtpAddresses.Count; $i++) {
            $match = $paList | where { $_.Substring(0,5) -ceq $smtpAddresses[$i].Substring(0,5) -and $_.Substring(5) -eq $smtpAddresses[$i].Substring(5) } | Measure-Object
            if ($match.Count -eq 0) {
                $paList.Add($smtpAddresses[$i])
            }
        }

        # remove duplicates if any
        $paList = $paList | select -Unique
        $paOriginalStr = ($user.proxyAddresses -join ",")
        $paUpdatedStr = ($paList -join ",")
        if ($paOriginalStr -cne $paUpdatedStr) {
            return $paList
        }
        else {
            return $null
        }
    }
}




while ($true) {
    Write-Output ("`r`n")
    $sAMAccountName = Read-Host -Prompt "Enter user sAMAccountName >> "
    Write-Output ("`r`n")

    if ([string]::IsNullOrEmpty($sAMAccountName)) {
        break
    }
    
    $user = Get-ADUser -Server $pdcName -LDAPFilter ("(&(ObjectCategory=user)(objectcategory=person)(sAMAccountName={0}))" -f $sAMAccountName) -Properties cn,enabled,mail,userprincipalname,sAMAccountName,extensionAttribute1,mailNickname,proxyAddresses,targetAddress,mail
    if ($user -eq $null) {
        Write-Output ("  Unable to find a user with sAMAccountName '{0}'!`r`n`r`n" -f $sAMAccountName)
    }
    else {
        Write-Output ("  Found user {0} - {1}...`r`n" -f $sAMAccountName,$user.cn)
        if ($user.Enabled -eq $false) {
            Write-Output ("    Error: User account is disabled, the user must be enabled and have a mail address to enable O365!")
            Write-Output ("    Error: Please correct this in AD and then re-enter the sAMAccountName.`r`n`r`n")
        }
        elseif ([string]::IsNullOrEmpty($user.mail)) {
            Write-Output ("    Error: User account does not have a mail attribute, the user must be enabled and have a mail address to enable O365!")
            Write-Output ("    Error: Please correct this in AD and then re-enter the sAMAccountName.`r`n`r`n")
        }
        elseif ($user.mail.Contains(" ")) {
            Write-Output ("    Error: User email address has spaces in it, this is not allowed in O365!")
            Write-Output ("    Error: Please correct this in AD and then re-enter the sAMAccountName.`r`n`r`n")
        }
        elseif ($user.mail.Contains("'")) {
            Write-Output ("    Error: User email address has an apostrophe in it, this is not allowed in O365!")
            Write-Output ("    Error: Please correct this in AD and then re-enter the sAMAccountName.`r`n`r`n")
        }
        elseif ($user.mail.EndsWith("@praxair.com","CurrentCultureIgnoreCase") -eq $false) {
            Write-Output ("    Error: user email address is not @praxair.com!")
            Write-Output ("    Error: This utility is only designed for Praxair email addresses.`r`n`r`n")
        }
        else {
            ($localpart, $domainpart) = $user.mail.split("@")
            if ([string]::IsNullOrEmpty($localpart) -or [string]::IsNullOrEmpty($domainpart)) {
                Write-Output ("    Error: user email address does not appear to be formatted correctly?")
                Write-Output ("    Error: Please correct this in AD and then re-enter the sAMAccountName.`r`n`r`n")
            }
            else {
                $changes = @()

                Write-Output ("    Checking UserPrincipalName")
                if ($user.mail -eq $user.userPrincipalName) {
                    Write-Output ("      UserPrincipalName is correct!`r`n")
                }
                else {
                    Write-Output ("      UserPrincipalName should change from '{0}' to '{1}'`r`n" -f $user.UserPrincipalName,$user.mail)
                    $changes += @{"attribute"="UserPrincipalName";"oldValue"=$user.UserPrincipalName;"newValue"=$user.mail}
                }

                Write-Output ("    Checking MailNickname")
                if ($user.mailNickname -eq $user.UserPrincipalName.Split('@')[0]) {
                    Write-Output ("      MailNickname is correct!`r`n")
                }
                else {
                    Write-Output ("      MailNickname should change from '{0}' to '{1}'`r`n" -f $user.mailNickname,$user.UserPrincipalName.Split('@')[0])
                    $changes += @{"attribute"="MailNickname";"oldValue"=$user.mailNickname;"newValue"=$user.UserPrincipalName.Split('@')[0]}
                }

                Write-Output ("    Checking ExtensionAttribute1")
                if ($user.extensionAttribute1 -eq "aadsync") {
                    Write-Output ("      ExtensionAttribute1 is correct!`r`n")
                }
                else {
                    Write-Output ("      ExtensionAttribute1 should change from '{0}' to '{1}'`r`n" -f $user.extensionAttribute1,"aadsync")
                    $changes += @{"attribute"="ExtensionAttribute1";"oldValue"=$user.extensionAttribute1;"newValue"="aadsync"}
                }

                Write-Output ("    Checking TargetAddress")
                $migratedToO365 = Get-O365MigrationStatus -mailLocalpart $localpart -mailDomain $microsoftMailDomain -notesLdapConn $notesLdapConn
                if ($migratedToO365 -eq $true) {
                    $newTargetAddress = ("smtp:{0}@{1}" -f $localpart,"praxair.mail.onmicrosoft.com")
                    Write-Output ("      User is set up to use O365.")
                }
                elseif ($migratedToO365 -eq $false) {
                    $newTargetAddress = ("smtp:{0}@{1}" -f $localpart,$notesMailDomain)
                    Write-Output ("      User is set up to use IBM Notes.")
                }
                else {
                    $newTargetAddress = $null
                    Write-Output ("      Error: Unable to determine migration status, so can't check TargetAddress!`r`n")  # TODO: how to handle this? if it ever occurs...
                }
                if ($newTargetAddress -ne $null) {
                    if ($user.targetAddress -eq $newTargetAddress) {
                        Write-Output ("      TargetAddress is correct!`r`n")
                    }
                    else {
                        Write-Output ("      TargetAddress should change from '{0}' to '{1}'`r`n" -f $user.targetAddress,$newTargetAddress)
                        $changes += @{"attribute"="TargetAddress";"oldValue"=$user.targetAddress;"newValue"=$newTargetAddress}
                    }
                }

                Write-Output ("    Checking ProxyAddresses")
                $smtpList = @( ("SMTP:{0}@praxair.com" -f $localpart), ("smtp:{0}@praxair.mail.onmicrosoft.com" -f $localpart), ("smtp:{0}@praxair.onmicrosoft.com" -f $localpart) )
                $newPaList = Repair-ProxyAddressesAttribute -user $user -smtpAddresses $smtpList
                if ($newPaList -eq $null) {
                    Write-Output ("      ProxyAddresses is correct!`r`n")
                }
                else {
                    Write-Output ("      ProxyAddresses should change from '{0}' to '{1}'`r`n" -f ($user.proxyAddresses -join ","),($newPaList -join ","))
                    $changes += @{"attribute"="ProxyAddresses";"oldValue"=$user.proxyAddresses;"newValue"=$newPaList}
                }

                if ($changes.Count -eq 0) {
                    Write-Output ("  No changes to make, this user account is compatible with O365.`r`n`r`n")
                }
                else {
                    $resp = $null
                    while ($resp -eq $null) {
                        $resp = Read-Host -Prompt "  User account is not compatible with O365, make the required changes [y/n] >> "
                        if ($resp -ne "y" -and $resp -ne "n") {
                            $resp = $null
                            Write-Output ("  Please enter 'y' or 'n'.`r`n")
                        }
                    }

                    if ($resp -eq "y") {
                        foreach ($c in $changes) {
                            Write-Output ("  Updating {0}..." -f $c.attribute)
                            if ($c.newValue.GetType().Name -eq "String") {
                                if ([string]::IsNullOrEmpty($c.newValue)) {
                                    Set-ADUser -Identity $user -Server $pdcName -Clear $c.attribute
                                }
                                else {
                                    Set-ADUser -Identity $user -Server $pdcName -Replace @{$c.attribute=$c.newValue}
                                }
                            }
                            else { # array of proxyAddresses
                                if ($c.newValue.Count -eq 0) {
                                    Set-ADUser -Identity $user -Server $pdcName -Clear $c.attribute
                                }
                                else {
                                    Set-ADUser -Identity $user -Server $pdcName -Replace @{$c.attribute=$c.newValue}
                                }
                            }
                        }
                        Write-Output ("  All changes written to Active Directory!`r`n`r`n")
                    }
                    else {
                        Write-Output ("  Not making any changes to user! User will not be emailable from O365 users.`r`n`r`n")
                    }
                }
            }
        }
    }
}