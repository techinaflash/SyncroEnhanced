function Get-CustomerPhones {
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory=$True)]
        [string]$CustomerID
    )

   

    $ret = Invoke-SyncroAPIRequest -SyncroEndpoint "$($Global:SyncroCustomersAPIURI)/$($CustomerID)/phones" -Method Get 
    

    return $ret
}