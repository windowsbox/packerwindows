<#
.Synopsis
    Configures the network connection to private
.Description
    This cmdlet configures the net connection interface to be private
#>
function Set-NetworkToPrivate {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute("PSUseShouldProcessForStateChangingFunctions", "")]
    param()
    
    # Don't prompt for network location
    New-Item -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Network\NewNetworkWindowOff" -Force

    # Set network connection to private
    $netprofile = Get-NetConnectionProfile
    Set-NetConnectionProfile -InterfaceIndex $netprofile.InterfaceIndex -NetworkCategory Private 
}
