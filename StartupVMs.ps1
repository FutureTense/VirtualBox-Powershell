[string]$VBoxManage="C:\Program Files\Oracle\VirtualBox\VBoxManage.exe"

# If using ISE
if ($psISE) {
    $ScriptPath = Split-Path -Parent $psISE.CurrentFile.FullPath
# If Using PowerShell 3 or greater
} elseif($PSVersionTable.PSVersion.Major -gt 3) {
    $ScriptPath = $PSScriptRoot
# If using PowerShell 2 or lower
} else {
    $ScriptPath = split-path -parent $MyInvocation.MyCommand.Path
}

$ini = $MyInvocation.MyCommand.Name.Replace(".ps1",".ini")
$ini = [IO.Path]::Combine($ScriptPath,$ini)


$vms = Get-Content -Path $ini
foreach($vm in $vms)
{
    Write-Host "Starting Virtual Machine: " -NoNewline 
    Write-Host $vm.ToUpper() -ForegroundColor Yellow
		Write-Host ""
    $arguments = "startvm " + $vm + " --type headless"
    start-process $VboxManage $arguments 
} 
