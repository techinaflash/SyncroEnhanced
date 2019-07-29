$Global:SyncroAPIKey = $null
$Global:SyncroSubdomain = $null
#SyncroMSP Global Variables APIURI's

$Global:SyncroBaseAPIURI = "syncromsp.com/api/"
$Global:SyncroCustomersAPIURI ="v1/customers"
$Global:SyncroUserAPIURI = "v1/me"
$Global:SyncroLeadsAPIURI = "v1/leads"
$Global:SyncroContactsAPIURI = "v1/contacts"
$Global:SyncroInvoicesAPIURI = "v1/invoices"
$Global:SyncroPaymentMethodsAPIURI = "v1/payment_methods"
$Global:SyncroTicketsAPIURI = "v1/tickets"
$Global:SyncroSchedulesAPIURI = "v1/schedules"

function Set-SyncroAPIKey {
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory=$True)]
        [string]$APIKey
    )

    $Global:SyncroAPIKey = $APIKey
}

function Set-SyncroSubdomain {
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory=$True)]
        [string]$subdomain
    )

    $Global:SyncroSubdomain = $subdomain
}

function Get-FormattedURI {
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory=$False)]
        [string]$APIKey = $Global:SyncroAPIKey,
		
		[Parameter(Mandatory=$False)]
        [string]$SyncroBaseAPIURI = $Global:SyncroBaseAPIURI,
		
		[Parameter(Mandatory=$True)]
        [string]$SyncroEndpoint,
		
		#Used only for Get Requests		
		[Parameter(Mandatory=$False)]
        [object]$Params
		

		
    )
	#Write-Host $Params
	Add-Type -AssemblyName System.Web
		if (!$APIKey) {
			throw "API Key has not been set. Please use Set-SyncroAPIKey before calling this function."
		}elseif (!$($Global:SyncroSubdomain)) {
			throw "Subdomain has not been set. Please use Set-SyncroSubdomain before calling this function."
		} else {

			$Parameters = [System.Web.HttpUtility]::ParseQueryString([String]::Empty)
			$Parameters['api_key'] = $APIKey
			
			foreach($key in $Params.Keys){
				$Parameters[$key] = $Params.Item($key)
			}
			

			$Request = [System.UriBuilder]$SyncroEndpoint

			$Request.Query = $Parameters.ToString()
			Write-Host $Request 
			return $Request.Uri
		}
	
	
    
}

function Invoke-SyncroAPIRequest {
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory=$True)]
        [string]$SyncroEndpoint,

        [Parameter(Mandatory=$True)]
        [string]$Method,

        [Parameter(Mandatory=$False)]
        [object]$Params

        #[Parameter(Mandatory=$False)]
        #[string]$JSONRPC = "2.0",

        #[Parameter(Mandatory=$False)]
        #[int]$RequestID = 1
    )

	
	#$FormattedAPIUri = Get-FormattedURI -SyncroEndpoint "https://$($Global:SyncroSubdomain).$($Global:SyncroBaseAPIURI)$($SyncroEndpoint)" -Params $Params
    
 
	$body = ConvertTo-Json20 $Params
    
	if($method -eq "Post"){
		$FormattedAPIUri = Get-FormattedURI -SyncroEndpoint "https://$($Global:SyncroSubdomain).$($Global:SyncroBaseAPIURI)$($SyncroEndpoint)"     
		$Response = Invoke-WebRequest -Method $Method -Uri $FormattedAPIUri -Body $body -ContentType "application/json"
	}else{
		$FormattedAPIUri = Get-FormattedURI -SyncroEndpoint "https://$($Global:SyncroSubdomain).$($Global:SyncroBaseAPIURI)$($SyncroEndpoint)" -Params $Params    
		$Response = Invoke-WebRequest -Method $Method -Uri $FormattedAPIUri
		
		 
	
	
    $Content = $Response.Content | ConvertFrom-Json	

	return $Content
	}
}

function Make-SyncroAPICall {
	[CmdletBinding()]
    Param(
        [Parameter(Mandatory=$True)]
        [string]$SyncroEndpoint,

        [Parameter(Mandatory=$True)]
        [string]$Method,

        [Parameter(Mandatory=$False)]
        [object]$Params

        #[Parameter(Mandatory=$False)]
        #[string]$JSONRPC = "2.0",

        #[Parameter(Mandatory=$False)]
        #[int]$RequestID = 1
    )
	#Formats the URI to use in the WebRequest20 functions
	#$FormattedAPIUri = Get-FormattedURI -SyncroEndpoint $SyncroEndpoint -Params $Params
    #$FormattedAPIUri
	
	#Testing purposes
	Write-Host $SyncroEndpoint
	Write-Host $Method
	Write-Host "Params are: $Params"
	Write-Host "https://$($Global:SyncroSubdomain).$($Global:SyncroBaseAPIURI)$($SyncroEndpoint)"
	#end testing
	
	
	if (!$($Global:SyncroAPIKey)) {
		throw "API Key has not been set. Please use Set-SyncroAPIKey before calling this function."
	}elseif (!$($Global:SyncroSubdomain)) {
		throw "Subdomain has not been set. Please use Set-SyncroSubdomain before calling this function."
	} else {
		$Parameters = @{}
		$Parameters['api_key'] = $($Global:SyncroAPIKey)
		foreach($key in $Params.Keys){
			$Parameters[$key] = $Params.Item($key)
		}
		
		Write-Host "Parameters are: $Parameters"
		$postParams = ConvertTo-Json20 -InputObject $Parameters
		Write-Host "postParams are: $postParams"
		
		$resp = try {
			$test = WebRequest20 -Uri "https://$($Global:SyncroSubdomain).$($Global:SyncroBaseAPIURI)$($SyncroEndpoint)" -Method $Method -Body $postParams -ContentType 'application/json'
			Write-Host $test
			Write-Host "Success"
		} catch {
			Write-Host "ERROR! : $_"
			$result = $_.Exception.Response.GetResponseStream()
			$reader = New-Object System.IO.StreamReader($result)
			$reader.BaseStream.Position = 0
			$reader.DiscardBufferedData()
			$responseBody = $reader.ReadToEnd();
			Write-Host $responseBody
		}
		
		$resp
	}
}

