<#
.SYNOPSIS
This PowerShell script ensures the built-in or attached camera is disabled by setting the webcam consent store registry value to Deny.

.NOTES
    Author          : Robert Vargas
    LinkedIn        : linkedin.com/in/robert-vargas/
    GitHub          : github.com/robertcvargas
    Date Created    : 2026-09-19
    Last Modified   : 2026-09-19
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN11-CC-000007
    Documentation   : https://stigaview.com/products/win11/v2r8/WN11-CC-000007/

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\__remediation_template(STIG-ID-WN11-CC-000007).ps1 
#>

$RegistryPath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\webcam"
$Name         = "Value"
$Data         = "Deny"

if (-not (Test-Path $RegistryPath)) {
    New-Item -Path $RegistryPath -Force | Out-Null
}

New-ItemProperty -Path $RegistryPath -Name $Name -Value $Data -PropertyType String -Force | Out-Null

$Result = (Get-ItemProperty -Path $RegistryPath -Name $Name -ErrorAction SilentlyContinue).$Name

if ($Result -eq "Deny") {
    Write-Host "STIG WN11-CC-000007 remediated: Camera access set to Deny." -ForegroundColor Green
} else {
    Write-Host "WARNING: Verification failed. Current value: $Result" -ForegroundColor Red
}
