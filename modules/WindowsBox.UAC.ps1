<#
.Synopsis
    Configures UAC
.Description
    This cmdlet configures Windows UAC
#>
function Disable-UAC {
    # Disable UAC
    Set-ItemProperty -Path HKLM:\Software\Microsoft\Windows\CurrentVersion\policies\system -Name EnableLUA -Value 0
}
