clear
$objWord = New-Object -Com Word.Application
 $DebugPreference = "Continue"
$filename = 'C:\Users\Edgar\Google Drive\Bretes\Freelance\magisterio\v2\Aplicacion Web.docx'
$objDocument = $objWord.Documents.Open($filename)

$sections  = $objDocument.Paragraphs

Write-Debug $objWord   | Format-Table | Out-String

foreach ($section in $sections) {
    Write-Host $section.Style 
  
  
  
  #  foreach ($header in $section.Headers) {
    #    Write-Debug $header.Range.Text
    # }
}
$objDocument.Close()
$objWord.Quit()
# Stop Winword Process
$rc = [System.Runtime.Interopservices.Marshal]::ReleaseComObject($objWord)

$DebugPreference = "SilentlyContinue"