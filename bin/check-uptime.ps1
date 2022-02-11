<#
.SYNOPSIS
   This plugin checks the Uptime and compares against the WARNING and CRITICAL thresholds.
.DESCRIPTION
   This plugin checks the Uptime and compares against the WARNING and CRITICAL thresholds.
.Notes
    FileName    : check-uptime.ps1
.PARAMETER Warning
    Required. Warning uptime days threshold
.PARAMETER Critical
    Required. Critical uptime days threshold
.EXAMPLE
    powershell.exe -file check-uptime.ps1 90 95
#>


#Requires -Version 3.0

[CmdletBinding()]
Param(
  [Parameter(Mandatory=$True,Position=1)]
   [int]$WARNING,

   [Parameter(Mandatory=$True,Position=2)]
   [int]$CRITICAL
)

$WMI = Get-WmiObject -Query "SELECT LastBootUpTime FROM Win32_OperatingSystem"
$NOW = Get-Date
$BOOTTIME = $WMI.ConvertToDateTime($WMI.LastBootUpTime)
$UPTIME = $NOW - $BOOTTIME


If ($UPTIME.days -ge $CRITICAL) {
  Write-Host CheckUPTIME CRITICAL: UPTIME $UPTIME.days days.
  Exit 2 }

If ($UPTIME.days -ge $WARNING) {
  Write-Host CheckUPTIME WARNING: UPTIME $UPTIME.days days.
  Exit 1 }

Else {
  Write-Host CheckUPTIME OK: UPTIME $UPTIME.days.
  Exit 0 }
