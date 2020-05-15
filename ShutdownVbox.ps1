[string]$VBoxManage="C:\Program Files\Oracle\VirtualBox\VBoxManage.exe"

$running = & $VBoxManage list runningvms 
do 
{
	Foreach ($vm in $running)
	{
			$vm = $vm|%{$_.split('"')[1]}
			echo $vm  “ shutting down”
			& $VBoxManage controlvm $vm acpipowerbutton
	}
	Start-Sleep -Seconds 1
	$running = & $VBoxManage list runningvms 
}
while ($running.Count -gt 0)
echo "finished"
