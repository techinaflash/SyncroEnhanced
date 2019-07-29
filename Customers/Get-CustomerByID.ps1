function Get-CustomerByID {
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory=$True)]
        [string]$ID
    )

   

    $ret = Invoke-SyncroAPIRequest -SyncroEndpoint "$($Global:SyncroCustomersAPIURI)/$($ID)" -Method Get -Params $Params
    

    return $ret.customer
}