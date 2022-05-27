 # https://docs.imperva.com/howto/c85245b7

 # Connect-AzAccount
 
 # Select Azure Subscription
 $subscriptionId = 
                 (Get-AzSubscription |
                 Out-GridView `
                 -Title "Select an Azure Subscription …" `
                     -PassThru).Id
Select-AzSubscription `
    -SubscriptionId $subscriptionId

$webApp = 
    (Get-AzWebApp | select-object -Property Name, ResourceGroup, Tags | Out-GridView -Title "Select Web App" -PassThru)

$ipList = 
    (Invoke-RestMethod -Uri https://my.imperva.com/api/integration/v1/ips -Method Post -Body "resp_format=text").trim()

$ipArray = $ipList -split "\n"

$ipArray

$resourceGroupName = $webApp.ResourceGroup
$webAppName = $webApp.Name
$priorityBegin = 100
$priorityIncrease = 1
$priority = $priorityBegin

for ( $i = 0; $i -lt $ipArray.Count; $i++)
{
    $itemCountDisplay = $i + 1
    Write-Information "$itemCountDisplay of $($ipArray.Count)"
    
    Add-AzWebAppAccessRestrictionRule -ResourceGroupName $resourceGroupName -WebAppName $webAppName `
        -Name "Imperva Range $itemCountDisplay" -IpAddress $ipArray[$i] `
        -Priority $priority -Action Allow
    
        $priority = $priority + $priorityIncrease
}

