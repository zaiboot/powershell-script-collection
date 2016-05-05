cls
$folderDirectory = 'c:\temp\'
$totalRecords =1000000
$fileName = 'salida.txt'
$csvDelimiter = "`t"
$baseObject = New-Object -TypeName PSObject -Property @{
        Id= 1
        Amount = 123
        Name ='Name to add'
    }


if (-Not (Test-Path -Path $folderDirectory))
{
    New-Item $folderDirectory -ItemType Directory 
}

$stream = [System.IO.StreamWriter] "$folderDirectory$fileName"
$stream.AutoFlush =$True
$csvString =  ($baseObject |  ConvertTo-Csv -Delimiter $csvDelimiter -NoTypeInformation)
$stream.WriteLine($csvString[0] ) #add the header

1..$totalRecords | % {
    $baseObject.Id += $_
    $baseObject.Name = "Name to add$_"
    $baseObject.Amount +=  $_

    $csvString =  ($baseObject |  ConvertTo-Csv -Delimiter $csvDelimiter -NoTypeInformation -Verbose)
    $stream.WriteLine($csvString[1] )
    $status ="{0:N0}  of {1:N0}" -f  $_ , $totalRecords
    Write-Progress  -Activity 'Writing records'  -Status $status  -PercentComplete  ($_ /$totalRecords*100)
} 
$stream.close()