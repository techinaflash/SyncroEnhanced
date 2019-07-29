function Get-SyncroTickets {
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory=$False)]
        [Nullable[int]]$TicketID,

        [Parameter(Mandatory=$False)]
        [Nullable[int]]$customer_id,
		
		[Alias("TicketNumber")]
		[Parameter(Mandatory=$False)]
        [Nullable[int]]$number,

        [Parameter(Mandatory=$False)]
        [string]$status,

        [Parameter(Mandatory=$False)]
        [DateTime]$resolved_after,

        [Parameter(Mandatory=$False)]
        [DateTime]$since_updated_at,

		#Subject Query
		[Alias("SubjectQuery")]
        [Parameter(Mandatory=$False)]
        [string]$term,

        [Parameter(Mandatory=$False)]
        [Nullable[bool]]$Mine,

        [Parameter(Mandatory=$False)]
        [Nullable[int]]$ticket_search_id
     )
    
    $Params = @{}

    if ($TicketID -eq $null){
      
       <#  if (!($CustomerID -eq $null)){
            $Params.customer_id = $CustomerID
        }

        if (!($TicketNumber -eq $null)){
            $Params.number = $TicketNumber
        }

        # Add a switch/case statement for all statuses to error check
        if (!($Status -eq "")){
            $Params.status = $Status
        }

        if (!($ResolvedAfter -eq $null)){
            $Params.resolved_after =  $ResolvedAfter.ToString("yyyy-MM-dd")
        }

        if (!($SinceUpdatedAt -eq $null)){
            $Params.since_updated_at =  $SinceUpdatedAt.ToString("yyyy-MM-dd")
        }

        if (!($SubjectQuery -eq "")){
            $Params.term = $SubjectQuery
        }
    
        #not sure if mine=false works here.
        if ($Mine -eq $True){
            $Params.mine = "true"
        }elseif ($Mine -eq $False){
            $Params.mine = "false"
        }

        if (!($CustomerID -eq $null)){
            $Params.customer_id = $CustomerID
        } #>
    
		$Params= @{}
		foreach($key in $PSBoundParameters.GetEnumerator()){
				$Params.Add($($key.key),$($key.value))
			}
		#$query = Convertto-Json20 $Params
        $ret = Invoke-SyncroAPIRequest -SyncroEndpoint $Global:SyncroTicketsAPIURI -Method Get -Params $Params
		
    }else{
        $ret = Invoke-SyncroAPIRequest -SyncroEndpoint "$($Global:SyncroTicketsAPIURI)/$($TicketID)" -Method Get
    }

    return $ret.tickets

}

function Get-SyncroTicketsCharges {
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory=$False)]
        [Nullable[int]]$TicketID,

        [Parameter(Mandatory=$False)]
        [Nullable[bool]]$ChargesOnly=$True
     )
       
    
    $ret = Get-SyncroTickets -TicketID $TicketID -ChargesOnly $ChargesOnly
    

    return $ret.ticket.line_items

}