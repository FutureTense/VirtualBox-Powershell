Param([parameter(Position=0)]$virtual_machine="vm_name",
      [parameter(Position=1)]$snapshot_name="")

[string]$VBoxManage="C:\Program Files\Oracle\VirtualBox\VBoxManage.exe"

Write-Host "Shutting down: " -NoNewline 
Write-Host  $virtual_machine.ToUpper() -ForegroundColor Green

$running = & $VBoxManage list runningvms 
echo $running

while ([bool]($running -match $virtual_machine))
{ 
   echo $virtual_machine  “ shutting down”
   & $VBoxManage controlvm $virtual_machine acpipowerbutton
   Start-Sleep -Seconds 1
   $running = & $VBoxManage list runningvms 
}

Start-Sleep -Seconds 4

if ($snapshot_name -eq "")
{
    $ftime = Get-Date -Format "MM-dd-yyyy HH:mm"
    $snapshot_name = "{0} {1}" -f $virtual_machine, $ftime
}

Write-Host "Taking snapshot: " -NoNewline 
Write-Host  $virtual_machine.ToUpper() " " -ForegroundColor Green -NoNewline 
Write-Host  $snapshot_name.ToUpper() -ForegroundColor Yellow

& $VBoxManage snapshot $virtual_machine take $snapshot_name
echo (-join('Snapshot: ',$snapshot_name))

$arguments = "startvm " + $virtual_machine + " --type headless"

Write-Host "Starting: " -NoNewline 
Write-Host  $virtual_machine.ToUpper() -ForegroundColor Green

& $VBoxManage startvm $virtual_machine --type headless


echo "finished"

