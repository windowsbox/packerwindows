# Runs after Windows Updates have been applied

. a:\modules\WindowsBox.AutoLogon.ps1
. a:\modules\WindowsBox.Compact.ps1
. a:\modules\WindowsBox.Explorer.ps1
. a:\modules\WindowsBox.Hibernation.ps1
. a:\modules\WindowsBox.RDP.ps1
. a:\modules\WindowsBox.UAC.ps1
. a:\modules\WindowsBox.VMGuestTools.ps1

Disable-AutoLogon
Disable-UAC
Enable-RDP
Set-ExplorerConfiguration
Disable-Hibernation
Install-VMGuestTools

# Install Docker if the provider is available on this OS
Install-Module DockerMsftProvider -Force
if ((Get-PackageProvider -ListAvailable).Name -Contains "DockerMsftProvider") {
  Install-Package -Name docker -ProviderName DockerMsftProvider -Force
}

# Final cleanup
Optimize-DiskUsage
