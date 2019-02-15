# This script runs on boot until Windows Updates complete
# then it enables WinRM

function WinUpdatesComplete() {
  $f = "C:\Windows\Temp\win-updates.log"
  if (!(Test-Path $f -PathType Leaf)) {
    return $false
  }
  return (select-string -Path $f -Pattern "Done Installing Windows Updates") -ne $null
}

$RegistryKey = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run"
$RegistryEntry = "CheckUpdatesComplete"

# Configure this script to run again if a reboot happens
Set-ItemProperty -Path $RegistryKey -Name $RegistryEntry -Value "C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe -NoLogo -ExecutionPolicy Bypass -File a:\winrm.ps1"

# Block until we find that Windows Updates have completed
while (!(WinUpdatesComplete)) {
  Start-Sleep -s 30
}

# Done Installing Windows Updates, remove this script from running on boot
$prop = (Get-ItemProperty $RegistryKey).$RegistryEntry
if ($prop) {
  Remove-ItemProperty -Path $RegistryKey -Name $RegistryEntry -ErrorAction SilentlyContinue
}

# Enable WinRM insecurely for local Packer provisioners
Install-Module WindowsBox.WinRM -Force
Enable-InsecureWinRM
