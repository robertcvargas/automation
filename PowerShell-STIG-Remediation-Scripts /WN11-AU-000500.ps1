<#
.SYNOPSIS
This PowerShell script ensures the Windows account lockout duration is configured to 15 minutes or greater.

.NOTES
    Author          : Robert Vargas
    LinkedIn        : linkedin.com/in/robert-vargas/
    GitHub          : github.com/robertcvargas
    Date Created    : 2026-09-20
    Last Modified   : 2026-09-20
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN11-AU-000500
    Documentation   : https://stigaview.com/products/win11/v2r8/WN11-AU-000500/

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
 PS C:\> .\__remediation_template(STIG-ID-WN10-AU-000500).ps1 

#>

$RegistryPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\EventLog\Application"
$Name         = "MaxSize"
$Value        = 32768

if (-not (Test-Path $RegistryPath)) {
    New-Item -Path $RegistryPath -Force | Out-Null
}

New-ItemProperty -Path $RegistryPath -Name $Name -Value $Value -PropertyType DWord -Force | Out-Null

$Result = (Get-ItemProperty -Path $RegistryPath -Name $Name -ErrorAction SilentlyContinue).$Name

if ($Result -eq 32768) {
    Write-Host "STIG WN11-AU-000500 remediated: Application event log max size set to 32768 KB." -ForegroundColor Green
} else {
    Write-Host "WARNING: Verification failed. Current value: $Result" -ForegroundColor Red
}
