# ----------------------------------------------------------------------------------------------------
# This would need to be run on the DNS server in its current form.

# Parameters
$ZoneName = "domain.local"
$RecordType = "A" #may need CNAME here instead of A
$RecordName = "server1"
$NewTTL = 5 #This figure is in minutes

$OldObj = Get-DnsServerResourceRecord -Name $RecordName -ZoneName $ZoneName -RRType $RecordType
$NewObj = [ciminstance]::new($OldObj)
$NewObj.TimeToLive = [System.TimeSpan]::FromMinutes($NewTTL)
Set-DnsServerResourceRecord -NewInputObject $NewObj -OldInputObject $OldObj -ZoneName $ZoneName #-PassThru

# Confirm updates
Get-DnsServerResourceRecord -Name $RecordName -ZoneName $ZoneName -RRType $RecordType
#----------------------------------------------------------------------------------------------------


#----------------------------------------------------------------------------------------------------
# Run this against individual non-DNS servers that will be part of testing in the failover event,
# Or just wait 1 hour for the cache to expire on all of the the servers that have it cached.
# This could potentially cause disruption so omit this if possible.
Clear-DnsClientCache
#----------------------------------------------------------------------------------------------------