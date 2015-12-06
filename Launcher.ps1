<#
Script Name:    Launcher.ps1
Author:         Cory Knox
Email:          github.powershell@knoxy.ca
Version:        0.0.1
Raison d'etre:  Have set of scripts in scripts folder. Create GUI to launch them.
Requirements:   ShowUI (cloned from: https://github.com/show-ui/ShowUI)
                PowerShell 3 (I think, only tested on PowerShell 5 Windows 7/10)
                Elevation *not* required
				requirements of the scripts apply if you want to run them.
ToDo:           
#>
Import-Module ShowUI
$scriptRoot = "$PSScriptRoot\scripts\"
$scripts = Get-ChildItem "$scriptRoot*.ps1"


New-StackPanel -Children {
	foreach ($script in $scripts) {
		New-Button -Content "$($script.BaseName)" -tag $script -On_Click{
			& $this.tag.FullName
		}
	}
} -Show
