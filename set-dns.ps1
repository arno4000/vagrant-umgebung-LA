#This script sets the DNS on the second server and the client to the ip of the DC

# Get the Interface ID of the Ethernet Interface
$ifIndex = (Get-NetAdapter | Where-Object { $_.Name -like "Ethernet" }).ifIndex
$dnsserver = "192.168.20.10"

# Set the DNS server
Set-DnsClientServerAddress -InterfaceIndex $ifIndex -ServerAddresses $dnsserver
