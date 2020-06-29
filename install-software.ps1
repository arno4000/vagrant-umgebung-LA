#Script to install Software on the client.

$software = "firefox", "notepadplusplus", "7zip", "vscode"

#Test if chocolatey is already installed, else install it
if (!(Get-Command chocolatey.exe -ErrorAction SilentlyContinue | Out-Null)) {
    Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
}

#Install the apps
foreach ($i in $software) {
    Write-Host "Installing $i..."
    chocolatey.exe install -y $i
}
