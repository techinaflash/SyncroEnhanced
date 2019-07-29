function Get-SyncroInvoices {
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory=$False)]
        [Nullable[bool]]$Paid,
		
		[Parameter(Mandatory=$False)]
        [Nullable[int]]$Ticket_ID,

        [Parameter(Mandatory=$False)]
        [DateTime]$SinceUpdatedAt
     )
    
    $Params = @{}

    if ($Paid -eq $False){
        $Params.unpaid = "true"
    }elseif ($Paid -eq $True){
        $Params.paid = "true"
    }
    
    if (!($Ticket_ID -eq $null)){
        $Params.ticket_id = $Ticket_ID
    }

    if (!($SinceUpdatedAt -eq $null)){
        $Params.since_updated_at =  $SinceUpdatedAt.ToString("yyyy-MM-dd")
    }

    $ret = Invoke-SyncroAPIRequest -SyncroEndpoint $Global:SyncroInvoicesAPIURI -Method Get -Params $Params
    

    return $ret

}