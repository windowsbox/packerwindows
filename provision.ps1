# Runs after Windows Updates have been applied and WinRM started

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
Optimize-DiskUsage
