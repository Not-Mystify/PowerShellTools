Add-Type -AssemblyName PresentationCore,PresentationFramework

# Check if admin. If not, request elevation and close old window.
If (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator))
{
  [System.Windows.MessageBox]::Show("PowerShell is going to ask for admin access. Please click Yes when it pops up.","Permissions",0,48)
  Start-Process powershell.exe "-File",('"{0}"' -f $MyInvocation.MyCommand.Path) -Verb RunAs
  exit
}

# Restart Network Adapters
$name = Get-NetAdapter | Select-Object -expandproperty Name
foreach ($result in $name) {
$message = 'Restarting: {0}' -f $result
Write-Output $message
Restart-NetAdapter -Name $result
}