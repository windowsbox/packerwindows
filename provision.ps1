# Runs after Windows Updates have been applied

Install-Module WindowsBox.AutoLogon -Force
Install-Module WindowsBox.Compact -Force
Install-Module WindowsBox.Explorer -Force
Install-Module WindowsBox.Hibernation -Force
Install-Module WindowsBox.RDP -Force
Install-Module WindowsBox.UAC -Force
Install-Module WindowsBox.VagrantAccount -Force
Install-Module WindowsBox.VMGuestTools -Force

Disable-AutoLogon
Disable-UAC
Enable-RDP
Set-ExplorerConfiguration
Disable-Hibernation
Set-VagrantAccount
Install-VMGuestTools

# Install Docker if the provider is available on this OS
Install-Module DockerMsftProvider -Force
if ((Get-PackageProvider -ListAvailable).Name -Contains "DockerMsftProvider") {
  Install-Package -Name docker -ProviderName DockerMsftProvider -Force
}

if ($env:devtools -eq $true) {
  # Install Linux subsystem
  Install-Module WindowsBox.DevMode -Force
  Enable-DevMode

  # Install chocolatey and use it to install dev tools
  Invoke-WebRequest https://chocolatey.org/install.ps1 -UseBasicParsing | Invoke-Expression

  choco install powershell-packagemanagement -y
  choco install visualstudio2019community -y
  choco install visualstudio2019-workload-netcoretools -y
  choco install visualstudio2019-workload-netweb -y
  choco install visualstudio2019-workload-node -y
  choco install visualstudio2019-workload-azure -y
  choco install visualstudio2019-workload-nativedesktop -y
  choco install visualstudio2019-workload-manageddesktop -y
  choco install resharper -y
  choco install notepadplusplus.install -y
  choco install googlechrome -y
  choco install git.install -y
  choco install beyondcompare -y
  choco install fiddler4 -y
  choco install sql-server-management-studio -y
  choco install nodejs.install -y
  choco install cloudfoundry-cli -y
  choco install nuget.commandline -y
  choco install soapui -y
}

# Final cleanup
Optimize-DiskUsage
