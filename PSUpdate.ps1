##This script will confirm the instance name and if the time is correct it will start the server update 

$userName = whoami 
$currenttime = Get-Date  -UFormat %R

##Disable-PSRemoting (disable remote powershell execution)

if ($userName -eq 'desktop-oaag0e5\w10d1') {
    Write-Host 'Script Success' 
}

if ($currenttime -eq '15:28') {
    Write-Host 'Starting Server Update'
}
##Clear variables assigned at start of script(CLEANUP YOUR MESS!!!)
Clear-Variable -Name 'userName'
Clear-Variable -Name 'currenttime'

#
