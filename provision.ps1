# Runs after Windows Updates have been applied and WinRM started

Install-Module WindowsBox.AutoLogon -Force
Install-Module WindowsBox.Compact -Force
Install-Module WindowsBox.Explorer -Force
Install-Module WindowsBox.Hibernation -Force
Install-Module WindowsBox.RDP -Force
Install-Module WindowsBox.UAC -Force
Install-Module WindowsBox.VagrantAccount -Force
Install-Module WindowsBox.VMGuestTools -Force
Install-Module WindowsBox.DevTools -Force

Disable-AutoLogon
Disable-UAC
Enable-RDP
Enable-DevTools
Set-ExplorerConfiguration
Disable-Hibernation
Set-VagrantAccount
Install-VMGuestTools
Optimize-DiskUsage
