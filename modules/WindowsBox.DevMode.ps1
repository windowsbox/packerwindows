<#
.Synopsis
    Enables developer mode and Ubuntu subsystem
.Description
    Enables Windows developer mode and the Ubuntu subsystem and BASH shell
#>
function Enable-DevMode {
  # Enable developer mode which is required in order to install Ubuntu subsystem
  $RegistryKeyPath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\AppModelUnlock"
  if (-not(Test-Path -Path $RegistryKeyPath)) {
    New-Item -Path $RegistryKeyPath -ItemType Directory -Force
  }
  New-ItemProperty -Path $RegistryKeyPath -Name AllowDevelopmentWithoutDevLicense -PropertyType DWORD -Value 1

  # Install Ubuntu subsystem
  Enable-WindowsOptionalFeature -Online -NoRestart -FeatureName Microsoft-Windows-Subsystem-Linux
}
