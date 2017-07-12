# Runs before Packer provisioners during first boot

# We explicitly install nuget because install-module prompts for confirmation even with -Force
Install-PackageProvider -Name Nuget -Force

# Install and execute Windows updates and start WinRM when complete
Install-Module WindowsBox.Network -Force
Install-Module WindowsBox.WindowsUpdates -Force

Set-NetworkToPrivate
Install-WindowsUpdates
