<#
.Synopsis
    Configures RDP
.Description
    This cmdlet configures Windows RDP
#>
function Enable-RDP {
    # Enable RDP
    Set-ItemProperty -Path "HKLM:\System\CurrentControlSet\Control\Terminal Server" -Name fDenyTSConnections -Type DWord -Value 0

    # Disable Network Level Authentication
    $ts = Get-CimInstance -Namespace root\cimv2\terminalservices -ClassName Win32_TSGeneralSetting -Filter 'TerminalName = "RDP-Tcp"'
    $ts | Invoke-CimMethod -MethodName SetUserAuthenticationRequired -Arguments @{UserAuthenticationRequired=0} | Out-Null
    
    # Enable RDP on the firewall
    Enable-NetFirewallRule -DisplayName 'Remote Desktop - User Mode (TCP-in)'
}
