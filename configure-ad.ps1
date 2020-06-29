# wait until we can access the AD. this is needed to prevent errors like:
#   Unable to find a default server with Active Directory Web Services running.
while ($true) {
    try {
        Get-ADDomain | Out-Null
        break
    }
    catch {
        Start-Sleep -Seconds 10
    }
}


$adDomain = Get-ADDomain
$domain = $adDomain.DNSRoot
$domainDn = $adDomain.DistinguishedName
$usersAdPath = "CN=Users,$domainDn"
$password = ConvertTo-SecureString -AsPlainText 'Welcome!20' -Force


# remove the non-routable vagrant nat ip address from dns.
# NB this is needed to prevent the non-routable ip address from
#    being registered in the dns server.
# NB the nat interface is the first dhcp interface of the machine.
$vagrantNatAdapter = Get-NetAdapter -Physical `
| Where-Object { $_ | Get-NetIPAddress | Where-Object { $_.PrefixOrigin -eq 'Dhcp' } } `
| Sort-Object -Property Name `
| Select-Object -First 1
$vagrantNatIpAddress = ($vagrantNatAdapter | Get-NetIPAddress).IPv4Address
# remove the $domain nat ip address resource records from dns.
$vagrantNatAdapter | Set-DnsClient -RegisterThisConnectionsAddress $false
Get-DnsServerResourceRecord -ZoneName $domain -Type 1 `
| Where-Object { $_.RecordData.IPv4Address -eq $vagrantNatIpAddress } `
| Remove-DnsServerResourceRecord -ZoneName $domain -Force
# disable ipv6.
$vagrantNatAdapter | Disable-NetAdapterBinding -ComponentID ms_tcpip6
# remove the dc.$domain nat ip address resource record from dns.
$dnsServerSettings = Get-DnsServerSetting -All
$dnsServerSettings.ListeningIPAddress = @(
    $dnsServerSettings.ListeningIPAddress `
    | Where-Object { $_ -ne $vagrantNatIpAddress }
)
Set-DnsServerSetting $dnsServerSettings
# flush the dns client cache.
Clear-DnsClientCache

#Create DNS reverse lookup zone
Add-DnsServerPrimaryZone -NetworkID "192.168.20.0/24" -ZoneFile "20.168.192.in-addr.arpa.dns"

#Add PTR records
Add-DnsServerResourceRecordPtr -Name "20" -ZoneName "20.168.192.in-addr.arpa" -AllowUpdateAny -PtrDomainName "srv02.vagrant.lab"
Add-DnsServerResourceRecordPtr -Name "30" -ZoneName "20.168.192.in-addr.arpa" -AllowUpdateAny -PtrDomainName "cli01.vagrant.lab"

# set the Administrator password.
# NB this is also an Domain Administrator account.
Set-ADAccountPassword `
    -Identity "CN=Administrator,$usersAdPath" `
    -Reset `
    -NewPassword $password
Set-ADUser `
    -Identity "CN=Administrator,$usersAdPath" `
    -PasswordNeverExpires $true
