<#
.Synopsis
    Install VM Guest Tools
.Description
    This cmdlet installs VM Guest tools for vSphere from a mounted CD
#>
function Install-VMGuestTools {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute("PSUseSingularNouns", "")]
    param()
    
    $installed = $false
    foreach ($drive in Get-PSDrive -PSProvider 'FileSystem') {
        $setup = "$($drive.Root)setup64.exe"

        if (Test-Path $setup) {
            Start-Process -FilePath $setup -ArgumentList '/S /v /qn' -Wait
            #setup.exe /S /v "/qn /l*v ""%TEMP%\vmmsi.log"" REBOOT=R ADDLOCAL=ALL REMOVE=Hgfs"
            $installed = $true
        }
    }

    if (!$installed) {
        Write-Error "Guest additions were not installed, did you forget to mount the ISO?"
    }
}
