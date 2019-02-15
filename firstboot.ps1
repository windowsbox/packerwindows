# Runs before Packer provisioners during first boot

# We explicitly install nuget because install-module prompts for confirmation even with -Force
Install-PackageProvider -Name Nuget -Force

# Configure the network to private so we can properly configure WinRM
Install-Module WindowsBox.Network -Force
Set-NetworkToPrivate

# Kick off the WinRM script that polls for updates to be complete
Start-Job -ScriptBlock { C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe -NoLogo -ExecutionPolicy Bypass -File a:\winrm.ps1 }

# Install all available Windows updates
Install-Module WindowsBox.WindowsUpdates -Force
Install-WindowsUpdates
