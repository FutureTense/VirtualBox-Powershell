Widows-R shell:startup
Paste shortcut to StartupVMs.ps1 (modify StartupVMs.ini with machine names) to start VMs in detached mode)

Create new Task Scheduler Task: IFTTT Monitor
Trigger: User logon (enable autologon)
Action: Start a program: powershell.exe
		Arugments: 		-windowstyle hidden -f "D:\Dropbox\PowershellNUC\IFTTT_Monitor.ps1"
		
Modify IFTTT_Monitor.ps1 to choose what PS scripts to launch based on keyword

Create IFTTT shortcut Execute $ to create file specified in D:\Dropbox\PowershellNUC\IFTTT_Monitor.ini