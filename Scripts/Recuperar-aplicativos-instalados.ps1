# Returns all MDM applications in the Intune Service
Get-IntuneApplication

# Returns an application by Name in the Intune Service
Get-IntuneApplication -Name "Microsoft Excel"

# Returns all MDM application and selects the displayName, id and type
Get-IntuneApplication | select displayName,id,'@odata.type' | sort displayName