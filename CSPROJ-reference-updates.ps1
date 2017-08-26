clear
$baseFolder = $env:USERPROFILE  + '\projects\Certification\Reconciliation\'
$wildcards = '*.csproj'

(ls -Path $baseFolder -Filter $wildcards -Recurse -File ).FullName| % { 

        (gc $_).Replace('LogentriesLog4net, Version=2.8.0.0,', 'LogentriesLog4net,') | Set-Content $_
        $status ="{0}" -f  $_ , $totalRecords
        Write-Progress  -Activity 'Updating references'  -Status $status       

} 

