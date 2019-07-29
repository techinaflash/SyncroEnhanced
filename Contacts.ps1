function Get-SyncroContacts {
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory=$True)]
        [string]$CustomerID
    )

    $Params = @{}

    $Params.customer_id = $CustomerID
   

    $ret = Invoke-SyncroAPIRequest -SyncroEndpoint $Global:SyncroContactsAPIURI -Method Get -Params $Params
    

    return $ret
}