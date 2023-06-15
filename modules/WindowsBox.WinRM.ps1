<#
.Synopsis
    Enables WinRM insecurely over http (use only for localhost connections)
.Description
    This cmdlet enables the WinRM endpoint using http and basic auth. This should
    only be used via localhost since username and password are sent unencrypted
    over the network.
#>
function Enable-InsecureWinRM {
    # Ensure the Windows firewall allows WinRM https traffic over port 5985
    Enable-NetFirewallRule -DisplayName 'Windows Remote Management (HTTP-In)'

    Enable-WinRMConfiguration

    # Enable insecure basic auth over http
    winrm set winrm/config/service '@{AllowUnencrypted="true"}'
    winrm set winrm/config/service/auth '@{Basic="true"}'
}

<#
.Synopsis
    Enables WinRM over https
.Description
    This cmdlet enables the WinRM endpoint using https and basic auth. This creates
    a self signed cert so you'll need to ensure your client ignores cert validation
    errors.
#>
function Enable-WinRM {
    # Ensure the Windows firewall allows WinRM https traffic over port 5986
    New-NetFirewallRule -Name "WINRM-HTTPS-In-TCP" `
        -DisplayName "Windows Remote Management (HTTPS-In)" `
        -Description "Inbound rule for Windows Remote Management via WS-Management. [TCP 5986]" `
        -Group "Windows Remote Management" `
        -Program "System" `
        -Protocol TCP `
        -LocalPort "5986" `
        -Action Allow `
        -Profile Domain,Private

    New-NetFirewallRule -Name "WINRM-HTTPS-In-TCP-PUBLIC" `
        -DisplayName "Windows Remote Management (HTTPS-In)" `
        -Description "Inbound rule for Windows Remote Management via WS-Management. [TCP 5986]" `
        -Group "Windows Remote Management" `
        -Program "System" `
        -Protocol TCP `
        -LocalPort "5986" `
        -Action Allow `
        -Profile Public

    Enable-WinRMConfiguration

    # Create self signed cert for TLS connections to WinRM
    $cert = New-SelfSignedCertificate -CertstoreLocation Cert:\LocalMachine\My -DnsName "winrm"
    New-Item -Path WSMan:\LocalHost\Listener -Transport HTTPS -Address * -CertificateThumbPrint $cert.Thumbprint -Force

    # Enable basic auth over https
    winrm set winrm/config/service '@{AllowUnencrypted="false"}'
    winrm set winrm/config/service/auth '@{Basic="true"}'
    winrm set 'winrm/config/listener?Address=*+Transport=HTTPS' "@{Port=`"5986`";Hostname=`"winrm`";CertificateThumbprint=`"$($cert.Thumbprint)`"}"
}

function Enable-WinRMConfiguration {
    # Enable WinRM with defaults
    Enable-PSRemoting -Force -SkipNetworkProfileCheck

    # Override defaults to allow unlimited shells/processes/memory
    winrm set winrm/config '@{MaxTimeoutms="7200000"}'
    winrm set winrm/config/winrs '@{MaxMemoryPerShellMB="0"}'
    winrm set winrm/config/winrs '@{MaxProcessesPerShell="0"}'
    winrm set winrm/config/winrs '@{MaxShellsPerUser="0"}'
}
