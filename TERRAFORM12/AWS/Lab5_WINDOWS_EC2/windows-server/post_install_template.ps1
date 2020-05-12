
Get-Disk
Write-Host "`n`n`n`n`n`n`n`n.........................SLEEP 60 ........................................................"
Start-Sleep -s 60
Get-Disk
Get-Volume


Write-Host "`n`n`n`n`n`n`n`n.........................Format disk D: ........................................................"
Set-Volume -DriveLetter D -NewFileSystemLabel "AP1"
Get-Disk
Get-Volume
Start-Sleep -s 1


Write-Host "`n`n`n`n`n`n`n`n.........................Format disk H: ......................................................."
Get-Partition -DiskNumber 2 | Set-Partition -NewDriveLetter H
Set-Volume -DriveLetter H -NewFileSystemLabel "AP2"
Get-Disk
Get-Volume
Start-Sleep -s 1


Write-Host "`n`n`n`n`n`n`n`n.........................Adding host to the domain ${vm_name_netbios}.........................."
$password = "${domain_admin_password}" -replace "`t|`n|`r","" | ConvertTo-SecureString -asPlainText -Force
$username = "${vm_name_netbios}\${vm_admin_user}"
$credential = New-Object System.Management.Automation.PSCredential($username,$password)
Add-Computer -DomainName ${vm_name_domain} -Credential $credential


Write-Host "`n`n`n`n`n`n`n`n..........................Adding host to Chef Server..........................................."
chef-client
chef-client -o "role[newborn]"
Start-Sleep -s 3

