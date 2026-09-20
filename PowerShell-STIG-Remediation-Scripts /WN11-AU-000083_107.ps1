<#
.SYNOPSIS
    This PowerShell script ensures that success auditing is enabled for both Other Object Access Events and Authorization Policy Change.

.NOTES
    Author          : Robert Vargas
    LinkedIn        : linkedin.com/in/robert-vargas/
    GitHub          : github.com/robertcvargas
    Date Created    : 2026-09-20
    Last Modified   : 2026-09-20
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN11-AU-000083, WN11-AU-000107
    Documentation   : https://stigaview.com/products/win11/v2r8/WN11-AU-000083/ , https://stigaview.com/products/win11/v2r8/WN11-AU-000107/

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\__remediation_template(STIG-ID-WN10-AU-000083_107).ps1 
#>

$Subcategories = @(
    "Other Object Access Events",
    "Authorization Policy Change"
)

foreach ($Sub in $Subcategories) {
    auditpol /set /subcategory:"$Sub" /success:enable | Out-Null
}

$AllPassed = $true

foreach ($Sub in $Subcategories) {
    $Result = auditpol /get /subcategory:"$Sub" | Select-String "Success"
    if ($Result -match "Success") {
        Write-Host "STIG remediated: '$Sub' success auditing enabled." -ForegroundColor Green
    } else {
        Write-Host "WARNING: '$Sub' verification failed. Current: $Result" -ForegroundColor Red
        $AllPassed = $false
    }
}

if ($AllPassed) {
    Write-Host "All STIGs (WN11-AU-000083, WN11-AU-000107) remediated successfully." -ForegroundColor Green
}
