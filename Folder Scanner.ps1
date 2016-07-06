clear
$folderToReview = '~\projects\'
$patternToInclude = '*.*'
$howmanyHoursAgo =-6;
$dateToMatchAgainst = (Get-Date).AddHours($howmanyHoursAgo)
ls $folderToReview  -Include $patternToInclude -Recurse | 
    where {
        $_.LastWriteTime -gt $dateToMatchAgainst.Date ;
            Write-Progress  -Activity 'Writing records'  -Status "File name: $_";    
    }  