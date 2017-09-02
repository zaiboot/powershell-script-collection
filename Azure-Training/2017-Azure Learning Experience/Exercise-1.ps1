#Login-AzureRmAccount
cls

$SubscriptionId = "aa276db1-d910-4227-956f-5affb9afe6a9"
function Build-Exercise (
    [string] $SubscriptionId ,
    [string] $Name,
    [string] $Location

)
{
    $webAppName = "edgar-azure-training-2017"
    $appServicePlan = "FreeAzurePlan"

    "Creating resource group $Name "
    New-AzureRmResourceGroup  -Name "$Name" -Location  $location
    New-AzureRmAppServicePlan -Location $location -Tier Free -ResourceGroupName $rgName -Name $appServicePlan
    $webApp = New-AzureRmWebApp -Name $webAppName -ResourceGroupName $rgName -Location $location -AppServicePlan $appServicePlan

    New-AzureRmAppServicePlan -Location $location -Tier Free -ResourceGroupName $rgName -Name "$appServicePlan-2"
    #Get-AzureRmResourceGroup -Location $location
}
$location = "EastUS"
$rgName = "Test"

Build-Exercise -Name $rgName -Location $Location -SubscriptionId $SubscriptionId
#Remove-AzureRmResourceGroup -Name $rgName -Force
#Get-AzureRmSubscription