# List All SSL Certificates Expiring in X Days

$DaysToExpired = 30   #Number of days to look for expiring certificates
$CountExpired = 0

$deadline = (Get-Date).AddDays($DaysToExpired)   #Set deadline date

Dir Cert:\LocalMachine\My | foreach {
  If ($_.NotAfter -le $deadline) { $_ | Select Issuer, Subject, NotAfter, @{Label="Expires In (Days)";Expression={($_.NotAfter - (Get-Date)).Days}}
  $CountExpired = $CountExpired + 1
  }
  }

If ($CountExpired -gt 0)
{
  Write-Host("You Have $CountExpired Certificates Expiring in less than $DaysToExpired Days.")
  Exit 1001
}else{
  Write-Host("No Certificates Expiring in less than $DaysToExpired Days.")
  Exit 0
}
