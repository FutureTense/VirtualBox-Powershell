$PSscript = "D:\VirtualBox-Powershell\TakeSnapshot.ps1"
$PSarg =  "noakland"
$ftime = Get-Date -Format "MM-dd-yyyy HH:mm"
$snapshot_name = "{0} {1}" -f $PSarg, $ftime
& $PSscript $PSarg $snapshot_name 0

$PSscript = "D:\VirtualBox-Powershell\RebootNUC.ps1"
& $PSscript
