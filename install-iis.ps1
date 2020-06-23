#Script to install the IIS-Webserver on srv02

if ($(Get-WindowsFeature -Name Web-Server).InstallState -eq "Installed") {
    Write-Host "The IIS-Webserver is already installed. Therefore it will not be installed."
}
else {
    Write-Host "Installing IIS-Webserver, this could take a few minutes"
    Install-WindowsFeature -Name Web-Server
    Install-WindowsFeature -Name Web-Mgmt-Tools
}