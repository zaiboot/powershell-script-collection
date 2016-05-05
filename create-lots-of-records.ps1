$whereToPutTheFile = 'C:\temp\'
$fileName ='file.txt'
$amountOfRecords= 1000000

$baseObject  = New-Object -TypeName PSObject -Property @{
    Id = 1
    Date = "5/4/2016"
    String = "abc"
}
$arrayOfItems= @()

1..$amountOfRecords | %{
    Write-Host "Generating object $_ of  $amountOfRecords"
    $arrayOfItems += $baseObject
}

$arrayOfItems | Export-Csv -Path  "$whereToPutTheFile$fileName" -NoTypeInformation -Verbose -Delimiter "`t"

#$stream = [System.IO.StreamWriter] "$whereToPutTheFile$fileName"
#$stream.WriteLine($arrayOfItems)
#$stream.close()