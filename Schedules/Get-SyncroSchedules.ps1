function Get-SyncroSchedules {
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory=$False)]
        [Nullable[bool]]$Paid,
		
		[Parameter(Mandatory=$False)]
        [Nullable[int]]$Ticket_ID,

        [Parameter(Mandatory=$False)]
        [DateTime]$SinceUpdatedAt,

        [Parameter(Mandatory=$False)]
        [Nullable[int]]$CustomerID
     )
    
<# INFORMATION FROM A GET REQUEST

To create a schedule you need to pass an invoice id as invoice_id to use as a template

1
id : 79933
account_id : 649
customer_id : 13495573
email_customer : true
frequency : "Monthly"
name : "Silver Simplify IT, Bill Wilkes Recurring Template, "
next_run : "2018-09-01"
snail_mail : false
charge_mop : true
invoice_unbilled_ticket_charges : false
paused : false
last_invoice_paid : null
lines
0
id : 148373
cost_cents : 100
description : "Monitoring & Automated Maintenance. Includes : - Daily Health Checks - Daily Safety Checks - Automatic Windows Updates - 3rd Party Program Updates (Flash, Java, Adobe Reader, etc.) - Weekly Automated Maintenance - Hardware Failure Monitoring - Software Failure Monitoring - Virus Protection - Malware Protection - Virus/Malware Remediation (if infected)"
name : "Silver Simplify I.T. (Monthly Subscription)"
position : 2
product_id : 1054065
quantity : "2.0"
retail_cents : 2000
schedule_id : 79933
taxable : false
user_id : null
price_cost : 1
price_retail : 20
product_category : " Managed Services;Preventive Maintenance"
asset_type_id : null
recurring_type_id : null
device_ids
#>

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

    if (!($CustomerID -eq $null)){
        $Params.customer_id = $CustomerID
    }

    $ret = Invoke-SyncroAPIRequest -SyncroEndpoint $Global:SyncroSchedulesAPIURI -Method Get -Params $Params
    

    return $ret

}