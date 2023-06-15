<#
.Synopsis
    Configures Explorer
.Description
    This cmdlet configures Windows Explorer
#>
function Set-ExplorerConfiguration {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute("PSUseShouldProcessForStateChangingFunctions", "")]
    param()
    
    # Show file extensions
    Set-ItemProperty HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced\ -name HideFileExt -value 0

    # Show hidden files
    Set-ItemProperty HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced\ -name Hidden -value 1
    
    # Show Run command in Start Menu
    Set-ItemProperty HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced\ -name Start_ShowRun -value 1

    # Show Administrative Tools in Start Menu
    Set-ItemProperty HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced\ -name StartMenuAdminTools -value 1

    # Enable QuickEdit mode
    Set-ItemProperty HKCU:\Console\ -name QuickEdit -value 1
}
