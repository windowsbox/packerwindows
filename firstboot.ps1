# Runs before Packer provisioners during first boot

# We explicitly install nuget because install-module prompts for confirmation even with -Force
Install-PackageProvider -Name Nuget -Force

# Configure the network to private so we can properly configure WinRM
Install-Module WindowsBox.Network -Force
Set-NetworkToPrivate

# Enable WinRM insecurely for local Packer provisioners
Install-Module WindowsBox.WinRM -Force
Enable-InsecureWinRM
