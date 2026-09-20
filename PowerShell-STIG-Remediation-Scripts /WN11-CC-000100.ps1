<#
.SYNOPSIS
This PowerShell script ensures that downloading print driver packages over HTTP is disabled by setting the DisableWebPnPDownload registry value to 1.

.NOTES
    Author          : Robert Vargas
    LinkedIn        : linkedin.com/in/robert-vargas/
    GitHub          : github.com/robertcvargas
    Date Created    : 2026-09-20
    Last Modified   : 2026-09-20
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN11-CC-000100
    Documentation   : https://stigaview.com/products/win11/v2r8/WN11-CC-000100/

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    PS C:\> .\__remediation_template(STIG-ID-WN11-CC-000100).ps1 
#>

$RegistryPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Printers"
$Name         = "DisableWebPnPDownload"
$Value        = 1

if (-not (Test-Path $RegistryPath)) {
    New-Item -Path $RegistryPath -Force | Out-Null
}

New-ItemProperty -Path $RegistryPath -Name $Name -Value $Value -PropertyType DWord -Force | Out-Null

$Result = (Get-ItemProperty -Path $RegistryPath -Name $Name -ErrorAction SilentlyContinue).$Name

if ($Result -eq 1) {
    Write-Host "STIG WN11-CC-000100 remediated: Print driver downloads over HTTP disabled." -ForegroundColor Green
} else {
    Write-Host "WARNING: Verification failed. Current value: $Result" -ForegroundColor Red
}
