# Add Azure WebApp Access Restrictions for Imperva IPs

## Description
This script will download the Imperva IP ranges and use the Azure Az Powershell scripts to add Access Restricions to allow only those IPs.  

## Instructions
To run, import AzureAz Module for powershell (https://docs.microsoft.com/en-us/powershell/azure)

Run `Connect-AzAccount`

Run `src/AllowImpervaIPs.ps1`.  It will ask which Subscription (if multiple).  Then it will download the list of WebApps and ask which app.  It will then create the Access Restrictions.  