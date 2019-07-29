function Get-SyncroLeads {
      

    $ret = Invoke-SyncroAPIRequest -SyncroEndpoint $Global:SyncroLeadsAPIURI -Method Get
    

    return $ret.leads
}

function Get-SyncroLeadsByID {
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory=$True)]
        [string]$ID
    )  

    $ret = Invoke-SyncroAPIRequest -SyncroEndpoint "$($Global:SyncroLeadsAPIURI)/$($ID)" -Method Get -Params $Params
    

    return $ret.lead
}

function Create-SyncroLead {
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory=$False)]
        [string]$first_name,
		
		[Parameter(Mandatory=$False)]
        [string]$last_name,
		
		[Parameter(Mandatory=$False)]
        [string]$email,
		
		[Parameter(Mandatory=$False)]
        [string]$phone,
		
		[Parameter(Mandatory=$False)]
        [string]$mobile,
		
		[Parameter(Mandatory=$False)]
        [string]$address,
		
		[Parameter(Mandatory=$False)]
        [string]$city,
		
		[Parameter(Mandatory=$False)]
        [string]$state,
		
		[Parameter(Mandatory=$False)]
        [string]$zip,
		
		[Parameter(Mandatory=$False)]
        [string]$ticket_subject,
		
		[Parameter(Mandatory=$False)]
        [string]$ticket_description,
		
		[Parameter(Mandatory=$False)]
        [string]$ticket_problem_type,
						
		[Parameter(Mandatory=$False)]
        [string]$ticket_id,
				
		[Parameter(Mandatory=$False)]
        [string]$customer_id,
		
		[Parameter(Mandatory=$False)]
        [string]$contact_id,
		
		[Parameter(Mandatory=$False)]
        [string]$file_url,
		
		[Parameter(Mandatory=$False)]
        [AllowEmptyCollection]$properties
    )  
	
	$Options = @{}
    
    if ($first_name) { $Options.first_name = $first_name }
    if ($last_name) { $Options.last_name = $last_name }
    if ($email) { $Options.email = $email }
	
	
	#Write-Host $PSBoundParameters
	#Write-Host $PSBoundParameters.GetEnumerator()
	$Params= @{}
	foreach($key in $PSBoundParameters.GetEnumerator()){
				#Write-Host "Key is $key"
				#Write-Host "Key.key is $($key.key)"
				#Write-Host "Key.value is $($key.value)"
				$Params.Add($($key.key),$($key.value))
				#Write-Host $Params.GetEnumerator() | Sort-Object -Property key
			}
	
	#Write-Host "Params are: "
	
	#Write-Host $Params.GetEnumerator() | Sort-Object -Property key
	#Write-Host "Bound Parameters are: $($PSBoundParameters.values)"
	
    $ret = Invoke-SyncroAPIRequest -SyncroEndpoint "$($Global:SyncroLeadsAPIURI)" -Method POST -Params $Params
    
	

    return $ret.lead
}

