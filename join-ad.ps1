#Script to Join the vagrant.lab domain


$domain = "vagrant.lab"
$user = "vagrant\Administrator"
$password = ConvertTo-SecureString -AsPlainText -Force -String "Welcome!20"
$adlogin = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $user, $password
Write-Host "Joining domain $domain, please wait..."
try {
    Add-Computer -DomainName $domain -Credential $adlogin -ErrorAction Stop
}
catch {
    Write-Host "Could not join domain $domain!! Please check for errors."
}
