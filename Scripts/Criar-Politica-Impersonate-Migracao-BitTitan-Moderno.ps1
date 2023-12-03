New-ThrottlingPolicy MigrationWizPolicy

## Retrieve the DistinguishedName property of the Group by using the Get-DistributionGroup command:
Get-DistributionGroup -Identity "MigrationWiz" |fl name, dist*

## Create a Management Scope
New-ManagementScope "MigrationWiz" -RecipientRestrictionFilter {MemberOfGroup -eq 'YourGroupDistinguisedName'}

## Create a Management Scope
New-ManagementScope "ScopeMigrationWiz" -RecipientRestrictionFilter {MemberOfGroup -eq 'CN=MigrationWiz20230105195147,OU=sindario.onmicrosoft.com,OU=Microsoft Exchange Hosted Organizations,DC=LAMPR80A005,DC=PROD,DC=OUTLOOK,DC=COM'}

## Create the Management Role Assignment
New-ManagementRoleAssignment -Name "Google-sindario" -Role "ApplicationImpersonation" -User "soucloud@sindario.onmicrosoft.com" -CustomRecipientWriteScope "ScopeMigrationWiz"


New-ManagementRoleAssignment -Role "ApplicationImpersonation" -User "soucloud@sindario.onmicrosoft.com"

Get-Mailbox -ResultSize Unlimited | Add-MailboxPermission -AccessRights FullAccess -Automapping $false -User soucloud@sindario.onmicrosoft.com