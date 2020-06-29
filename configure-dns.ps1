#Script to configure the DNS server on srv01

#Add reverse lookup zone
Add-DnsServerPrimaryZone -NetworkID "192.168.20.0/24" -ZoneFile "20.168.192.in-addr.arpa.dns"

#Add A records
Add-DnsServerResourceRecordA -Name "srv02" -ZoneName "vagrant.lab" -AllowUpdateAny -IPv4Address "192.168.20.20"
Add-DnsServerResourceRecordA -Name "cli01" -ZoneName "vagrant.lab" -AllowUpdateAny -IPv4Address "192.168.20.30"

#Add PTR records
Add-DnsServerResourceRecordPtr -Name "20" -ZoneName "20.168.192.in-addr.arpa" -AllowUpdateAny -PtrDomainName "srv02.vagrant.lab"
Add-DnsServerResourceRecordPtr -Name "30" -ZoneName "20.168.192.in-addr.arpa" -AllowUpdateAny -PtrDomainName "cli01.vagrant.lab"