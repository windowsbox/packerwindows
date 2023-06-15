<#
.Synopsis
    Optimize disk usage
.Description
    This cmdlet optimizes the disk usage of Windows
#>
function Optimize-DiskUsage {
    Write-Output "Cleaning Windows Update Files"
    Remove-Item "C:\Windows\SoftwareDistribution\Download" -Recurse -Force -ErrorAction SilentlyContinue
    mkdir C:\Windows\SoftwareDistribution\Download
    net start wuauserv

    Write-Output "Cleaning Temp Files"
    try {
        Takeown /d Y /R /f "C:\Windows\Temp\*"
        Icacls "C:\Windows\Temp\*" /GRANT:r administrators:F /T /c /q  2>&1
        Remove-Item "C:\Windows\Temp\*" -Recurse -Force -ErrorAction SilentlyContinue
    } catch {
        Write-Output 'Failed to remove some temp files'
    }

    Write-Output "Defragging C: Drive"
    Optimize-Volume -DriveLetter C

    Write-Output "Wiping Empty Space on C: Drive"
    $FilePath="c:\zero.tmp"
    $Volume = Get-CimInstance -ClassName Win32_LogicalDisk -Filter "DeviceID='C:'"
    $ArraySize= 64kb
    $SpaceToLeave= $Volume.Size * 0.05
    $FileSize= $Volume.FreeSpace - $SpacetoLeave
    $ZeroArray= new-object byte[]($ArraySize)
    
    $Stream= [io.File]::OpenWrite($FilePath)
    try {
    $CurFileSize = 0
        while($CurFileSize -lt $FileSize) {
            $Stream.Write($ZeroArray,0, $ZeroArray.Length)
            $CurFileSize +=$ZeroArray.Length
        }
    }
    finally {
        if($Stream) {
            $Stream.Close()
        }
    }
    
    Remove-Item $FilePath -Force -ErrorAction SilentlyContinue
}
