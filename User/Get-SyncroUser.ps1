function Get-SyncroUser {
      

    $ret = Invoke-SyncroAPIRequest -SyncroEndpoint $Global:SyncroUserAPIURI -Method Get
    

    return $ret
}