<#
.SYNOPSIS
This PowerShell script ensures that insecure guest logons to an SMB server are disabled by setting the AllowInsecureGuestAuth registry value to 0.

.NOTES
    Author          : Robert Vargas
    LinkedIn        : linkedin.com/in/robert-vargas/
    GitHub          : github.com/robertcvargas
    Date Created    : 2026-09-18
    Last Modified   : 2026-09-18
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN11-CC-000040
    Documentation   : https://stigaview.com/products/win11/v2r8/WN11-CC-000040/

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\__remediation_template(STIG-ID-WN11-CC-000040).ps1 
#>

$RegistryPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\LanmanWorkstation"
$Name         = "AllowInsecureGuestAuth"
$Value        = 0

if (-not (Test-Path $RegistryPath)) {
    New-Item -Path $RegistryPath -Force | Out-Null
}

New-ItemProperty -Path $RegistryPath -Name $Name -Value $Value -PropertyType DWord -Force | Out-Null

$Result = (Get-ItemProperty -Path $RegistryPath -Name $Name -ErrorAction SilentlyContinue).$Name

if ($Result -eq 0) {
    Write-Host "STIG WN11-CC-000040 remediated: Insecure guest logons to SMB disabled." -ForegroundColor Green
} else {
    Write-Host "WARNING: Verification failed. Current value: $Result" -ForegroundColor Red
}
