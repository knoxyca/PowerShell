<#
Script Name:    Main.ps1
Author:         Cory Knox
Email:          github.powershell@knoxy.ca
Version:        0.1
Requirements:   RSAT with Active Directory Module installed.
                ShowUI (cloned from: https://github.com/show-ui/ShowUI)
                PowerShell 3 (I think, only tested on PowerShell 5 Windows 7/10)
                Elevation *not* required
                User running script must have permissions to query Active Directory
ToDo:           Include error checking for users that don't exist.
                Check lockout status of account.
                Include option to Unlock account. 
#>
Import-Module ShowUI
#AD Commented out while building and testing on home machine without RSAT
#Import-Module ActiveDirectory
$global:pwdExpiryInDays = 182


$scripts = import-csv "$PSScriptRoot\configs\scripts.csv"

$scriptRoot = "$PSScriptRoot\scripts\"
#$scripts = Get-ChildItem "$scriptRoot*.ps1"

New-StackPanel -Children {
	foreach ($script in $scripts) {
    write-host $script
		New-Button -Content "$($script.baseName)" -tag @($script) -On_Click{
			write-host ($null -eq $this.tag)
		}
	}
} -Show
<#
TabControl {
  TabItem -Header "Launch Scripts" {
    StackPanel -Children {
      foreach ($script in $scripts) {
        Button -Content "$($script.baseName)" -tag $script -On_Click{
          switch($this.tag.Type) {
            "cmd" {start-process notepad.exe }
            "ps1" {write-host "This is a PowerShell script: $($this.tag.Location)"}
            default { write-host "Oops: $($this.tag.fullname)" }
          }
        }
      }
    }
  }
  TabItem -Header "AD Check" { 
    Grid -Columns auto,* -Rows 4 -Children {
      Label -Content "Username:"
      TextBox -name "Username" -Column 1
      Label -Content "Set:" -Row 1
      TextBox -name "pwdLastSet" -Row 1 -Column 1
      Label  -Content "Expires:" -Row 2
      TextBox -Name "pwdExpires" -Row 2 -Column 1
      Label -Row 3
      Button -Name "Button" -Content "Check Users Password" -Row 3 -Column 1 -IsDefault -On_Click{
        $user = get-aduser $username.text -properties pwdlastset
        $pwdSet = [datetime]::fromFileTime($user.pwdlastset)
        $pwdExp = $pwdSet.AddDays($pwdExpiryInDays)
        $pwdLastSet.text = $pwdSet
        $pwdExpires.text = $pwdExp
      }
    }
  } -On_Request_BringIntoView { $username.focus() }
  TabItem -Header "TWO" { StackPanel { Button "Four"; Button "Five"; Button "Six"; } }
} -show #>