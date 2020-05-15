$SleepTime = 5

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

$CommandFile = [IO.File]::ReadAllText($ini)

Do {

#Removes the file from the directory, in case the file was not deleted. Sets the error action in case the file is not present.
Remove-Item -Path $CommandFile -Force -ErrorAction SilentlyContinue

#Loop checking to see if the file has been created and once it has it continues on. Sleep in the look to prevent CPU pegging
Do {
Start-Sleep -Seconds $SleepTime
$FileCheck = Test-Path -Path $CommandFile
}
Until ($FileCheck -eq $True)

$IFTT= Get-Content $CommandFile -First 1

#Removes the shutdown file to prevent an imediate shutdown when the computer starts back up
Remove-Item -Path $CommandFile

#Shuts the computer down forcefully but gracefully
#Stop-Computer -Force

$TS = Get-Date -Format G



$PSarg = ""
switch ( $IFTT )
{
    Reboot
    {
       $PSscript = "D:\Dropbox\PowershellNUC\RebootNUC.ps1"
    }
    Shutdown
    {
       $PSscript = "D:\Dropbox\PowershellNUC\ShutdownVbox.ps1"
    }
    Snapshot
    {
       $PSscript = "D:\Dropbox\PowershellNUC\TakeSnapshot.ps1"
       $PSarg =  "HomeAssistant"
    }
    default 
    {
       $PSscript = 'unknown'
    }
}


$numTabs = 8

"$IFTT, $PSscript, $TS" | Out-File "$SearchDirectory\log.txt" -Append 

if (Test-Path $PSscript) 
{
    & $PSscript $PSarg
}
else 
{
    "No script"
}

 
} while (1)