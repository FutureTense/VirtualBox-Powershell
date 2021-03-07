Param([parameter(Position=0)]$virtual_machine="foobar",
      [parameter(Position=1)]$clone_name="")

[string]$VBoxManage="C:\Program Files\Oracle\VirtualBox\VBoxManage.exe"

if ($clone_name -eq "")
{
    $clone_name = $virtual_machine + ".BAK."
    $backupnum = 1
    $vms = & $VBoxManage list vms
    foreach ($vm in $vms) 
    {
        if ($vm.Contains($clone_name)) {
            Write-Host $vm
            $vmnum = $vm.Replace("`"","").Split()[0].split(".")[-1] -as [int]
            if ($vmnum -ge $backupnum)
            {
                $backupnum = $vmnum + 1
            }
        }
    }
    $clone_name = $clone_name + $backupnum
}

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
Start-Sleep -Seconds 1

Write-Host "Cloning: " -NoNewline 
Write-Host  $virtual_machine.ToUpper() -ForegroundColor Green -NoNewline 
Write-Host " to " -NoNewline 
Write-Host  $clone_name.ToUpper() -ForegroundColor Yellow

& $VBoxManage clonevm $virtual_machine --name=$clone_name --register --mode=machine --options=keepallmacs 

# if ($restart -ne 0) {}

$arguments = "startvm " + $virtual_machine + " --type headless"

Write-Host "Starting: " -NoNewline 
Write-Host  $virtual_machine.ToUpper() -ForegroundColor Green

& $VBoxManage startvm $virtual_machine --type headless


echo "finished"

Write-Host -NoNewLine 'Press any key to exit.';
$null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown');
