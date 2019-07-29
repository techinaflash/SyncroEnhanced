function Get-SyncroPaymentMethods {
      

    $ret = Invoke-SyncroAPIRequest -SyncroEndpoint $Global:SyncroPaymentMethodsAPIURI -Method Get
    

    return $ret
}