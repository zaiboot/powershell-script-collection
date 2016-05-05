$cred = Get-Credential
Login-AzureRmAccount -Credential $cred
Get-AzureSubscription | Format-Table