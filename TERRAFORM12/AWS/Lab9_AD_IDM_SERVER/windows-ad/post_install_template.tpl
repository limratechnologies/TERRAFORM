Get-Disk
Get-Volume

Write-Host "`n`n`n`n`n`n`n`n.........................Format disk D: ........................................................"
Get-Disk -Number 1 | Initialize-Disk -PartitionStyle MBR -PassThru | New-Partition -AssignDriveLetter -UseMaximumSize | Format-Volume -FileSystem NTFS -NewFileSystemLabel "APP" -Confirm:$false
Set-Volume -DriveLetter D -NewFileSystemLabel "APP"
Get-Disk
Get-Volume
Start-Sleep -s 1


Write-Host "`n`n`n`n`n`n`n`n.........................Format disk E: ........................................................"
Get-Disk -Number 2 | Initialize-Disk -PartitionStyle MBR -PassThru | New-Partition -AssignDriveLetter -UseMaximumSize | Format-Volume -FileSystem NTFS -NewFileSystemLabel "FF" -Confirm:$false
Set-Volume -DriveLetter E -NewFileSystemLabel "FF"
Get-Disk
Get-Volume
Start-Sleep -s 1


Set-NetFirewallProfile -Profile Domain,Public,Private -Enabled False

# Install DC role and DNS
Install-WindowsFeature "AD-Domain-Services","DNS","RSAT-ADDS-Tools","telnet-client","RSAT-DNS-Server"
Restart-Computer
