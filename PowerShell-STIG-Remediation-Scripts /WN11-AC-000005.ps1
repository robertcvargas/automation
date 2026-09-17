<#
.SYNOPSIS
This PowerShell script ensures the Windows account lockout duration is configured to 15 minutes or greater.

.NOTES
    Author          : Robert Vargas
    LinkedIn        : linkedin.com/in/robert-vargas/
    GitHub          : github.com/robertcvargas
    Date Created    : 2026-09-17
    Last Modified   : 2026-09-17
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN11-AU-000500
    Documentation   : https://stigaview.com/products/win11/v2r8/WN11-AC-000005/

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\__remediation_template(STIG-ID-WN10-AU-000500).ps1 
#>

$InfPath = "$env:TEMP\WN11-AC-000005.inf"
$DbPath  = "$env:TEMP\WN11-AC-000005.sdb"

@"
[Unicode]
Unicode=yes
[System Access]
LockoutDuration = 15
[Version]
signature="`$CHICAGO`$"
Revision=1
"@ | Out-File -FilePath $InfPath -Encoding unicode

secedit /configure /db $DbPath /cfg $InfPath /areas SECURITYPOLICY | Out-Null

Remove-Item $InfPath, $DbPath -Force -ErrorAction SilentlyContinue

$Result = (net accounts | Select-String "Lockout duration").ToString()

if ($Result -match "15") {
    Write-Host "STIG WN11-AC-000005 remediated: Account lockout duration set to 15 minutes." -ForegroundColor Green
} else {
    Write-Host "WARNING: Verification failed. Current setting: $Result" -ForegroundColor Red
}
