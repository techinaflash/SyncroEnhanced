function Get-CustomerSearch {
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory=$True)]
        [string]$Query
    )

    $Params = @{}

    $Params.query = $Query

    $ret = Invoke-SyncroAPIRequest -SyncroEndpoint $Global:SyncroCustomersAPIURI -Method Get -Params $Params
    

    return $ret

}