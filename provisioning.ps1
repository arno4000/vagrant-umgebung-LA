#This script is to run commands on the vagrant VMs.

#Install telnet client
#Check if telnet is already installed
if ((Get-WindowsFeature -name "Telnet-Client").InstallState -eq "Available") {
    Install-WindowsFeature -name "Telnet-Client"
}