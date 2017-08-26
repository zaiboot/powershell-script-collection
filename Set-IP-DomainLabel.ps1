$resourceGroupName  = 'ss-stg-rms-rg-1'
$ipName
$pip = Get-AzureRmPublicIpAddress -ResourceGroupName $resourceGroupName -name $ipName

$pip.DnsSettings = New-Object -TypeName "Microsoft.Azure.Commands.Network.Models.PSPublicIpAddressDnsSettings"
$pip.DnsSettings.DomainNameLabel = "ss-rms-stg-w1"
Set-AzureRmPublicIpAddress -PublicIpAddress $pip
