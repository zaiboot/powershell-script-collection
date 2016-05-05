cls              
$folderDirectory = 'c:\temp\'
$totalRecords 	 = 106 #1000000
$fileName		 = 'salida.txt'
$csvDelimiter	 = "`t"

function Generate-CSV-Array($record) {

    return ($baseObject |  ConvertTo-Csv -Delimiter $csvDelimiter -NoTypeInformation |% {$_.Replace('"','')}  )

}
$currencyCode ='USD'
$baseObject = New-Object -TypeName PSObject

Add-Member -InputObject $baseObject  -Name AccountSegment1 	-Value 'Acct1'		-MemberType NoteProperty 
Add-Member -InputObject $baseObject  -Name AccountSegment2 	-Value 'Acct2'		-MemberType NoteProperty 
Add-Member -InputObject $baseObject  -Name AccountSegment3 	-Value 'Acct3'		-MemberType NoteProperty 
Add-Member -InputObject $baseObject  -Name AccountSegment4 	-Value 'Acct4'		-MemberType NoteProperty 
Add-Member -InputObject $baseObject  -Name AccountSegment5 	-Value 'Acct5'		-MemberType NoteProperty 
Add-Member -InputObject $baseObject  -Name AccountSegment6 	-Value 'Acct6'		-MemberType NoteProperty 
Add-Member -InputObject $baseObject  -Name AccountSegment7 	-Value 'Acct7'		-MemberType NoteProperty 
Add-Member -InputObject $baseObject  -Name AccountSegment8 	-Value 'Acct8'		-MemberType NoteProperty 
Add-Member -InputObject $baseObject  -Name AccountSegment9 	-Value 'Acct9'		-MemberType NoteProperty 
Add-Member -InputObject $baseObject  -Name AccountSegment10 -Value 'Acct0'		-MemberType NoteProperty 
Add-Member -InputObject $baseObject  -Name AccountName 		-Value 'AcctName'   -MemberType NoteProperty 
Add-Member -InputObject $baseObject  -Name CCY1Code 		-Value $currencyCode -MemberType NoteProperty 
Add-Member -InputObject $baseObject  -Name CCY1EndBalance 	-Value 1.0  		-MemberType NoteProperty 
Add-Member -InputObject $baseObject  -Name CCY2Code 		-Value $currencyCode -MemberType NoteProperty 
Add-Member -InputObject $baseObject  -Name CCY2EndBalance 	-Value 2.0        	-MemberType NoteProperty 
Add-Member -InputObject $baseObject  -Name CCY3Code 		-Value $currencyCode     -MemberType NoteProperty 
Add-Member -InputObject $baseObject  -Name CCY3EndBalance	-Value 3.0        	-MemberType NoteProperty 
Add-Member -InputObject $baseObject  -Name Period			-Value 5        	-MemberType NoteProperty 
Add-Member -InputObject $baseObject  -Name Year 			-Value 2016        	-MemberType NoteProperty 
Add-Member -InputObject $baseObject  -Name EffectiveDate	-Value '5/31/2016'	-MemberType NoteProperty 




if (-Not (Test-Path -Path $folderDirectory))
{
    New-Item $folderDirectory -ItemType Directory 
}

$stream = [System.IO.StreamWriter] "$folderDirectory$fileName"
Try{

    $stream.AutoFlush =$True
    $csvString =  Generate-CSV-Array($baseObject)
    $stream.WriteLine($csvString[0] ) #add the header

    1..$totalRecords | % {

        $baseObject.AccountSegment1 ="AccountSegment1$_"
        $baseObject.AccountName = "Name to add$_"
        $baseObject.CCY1EndBalance +=  $_/10

        $csvString =  Generate-CSV-Array($baseObject)
        $stream.WriteLine($csvString[1] )
        $status ="{0:N0}  of {1:N0}" -f  $_ , $totalRecords
        Write-Progress  -Activity 'Writing records'  -Status $status  -PercentComplete  ($_ /$totalRecords*100)
    } 
}
      finally {
        $stream.close()
      }

