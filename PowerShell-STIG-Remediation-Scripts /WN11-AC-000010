<#
.SYNOPSIS
This PowerShell script ensures the account lockout threshold is configured to 3 invalid logon attempts or less.

.NOTES
    Author          : Robert Vargas
    LinkedIn        : linkedin.com/in/robert-vargas/
    GitHub          : github.com/robertcvargas
    Date Created    : 2026-09-18
    Last Modified   : 2026-09-18
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN11-AC-000010
    Documentation   : https://stigaview.com/products/win11/v2r8/WN11-AC-000010/

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\__remediation_template(STIG-ID-WN11-AC-000010).ps1 
#>

$InfPath = "$env:TEMP\WN11-AC-000010.inf"
$DbPath  = "$env:TEMP\WN11-AC-000010.sdb"

@"
[Unicode]
Unicode=yes
[System Access]
LockoutBadCount = 3
[Version]
signature="`$CHICAGO`$"
Revision=1
"@ | Out-File -FilePath $InfPath -Encoding unicode

secedit /configure /db $DbPath /cfg $InfPath /areas SECURITYPOLICY | Out-Null

Remove-Item $InfPath, $DbPath -Force -ErrorAction SilentlyContinue

$Result = (net accounts | Select-String "Lockout threshold").ToString()

if ($Result -match "3") {
    Write-Host "STIG WN11-AC-000010 remediated: Account lockout threshold set to 3 invalid attempts." -ForegroundColor Green
} else {
    Write-Host "WARNING: Verification failed. Current setting: $Result" -ForegroundColor Red
}
