<#
.Synopsis
    Configures Hibernation
.Description
    This cmdlet configures Windows Hibernation
#>
function Disable-Hibernation {
    Set-ItemProperty HKLM:\SYSTEM\CurrentControlSet\Control\Power\ -name HiberFileSizePercent -value 0
    Set-ItemProperty HKLM:\SYSTEM\CurrentControlSet\Control\Power\ -name HibernateEnabled -value 0
}
