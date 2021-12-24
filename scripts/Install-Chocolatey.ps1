<#
.SYNOPSIS
Install Chocolatey

.DESCRIPTION
This script installs and/or upgrades Chocolatey package manager

.EXAMPLE
.\Install-Chocolatey.ps1
#>

# Script for Installing Chocolatey
$cachePath = Set-TempDirectory
$checkChoco = powershell choco -v
if (-not($checkChoco)) {
    Write-Output "Chocolatey is not found. Installing it now..."
    Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
} else {
    Write-Output "Chocolatey detected. Checking for upgrade..."
    choco upgrade -cache $cachePath -y chocolatey
}

Write-Output  "Creating daily task to automatically upgrade Chocolatey packages"
# adapted from https://blogs.technet.microsoft.com/heyscriptingguy/2013/11/23/using-scheduled-tasks-and-scheduled-jobs-in-powershell/
$ScheduledJob = @{
    Name = "Chocolatey Daily Upgrade"
    ScriptBlock = {choco upgrade all -y}
    Trigger = New-JobTrigger -Daily -at 2am
    ScheduledJobOption = New-ScheduledJobOption -RunElevated -MultipleInstancePolicy StopExisting -RequireNetwork
}
Register-ScheduledJob @ScheduledJob
