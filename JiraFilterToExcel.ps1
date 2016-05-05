#Requirements:
# * PSExcel : https://www.powershellgallery.com/packages/PSExcel 
clear
 Import-Module PSExcel

function ConvertTo-Base64($string) {
	$bytes = [System.Text.Encoding]::UTF8.GetBytes($string);
	$encoded = [System.Convert]::ToBase64String($bytes);
	return $encoded;
}


$userName=''
$password=''
## we only have access to use basic auth, no OAuth enabled
$encodedCredentials = ConvertTo-Base64("${userName}:${password}")
$baseAtlassianUrl = 'https://trintech.atlassian.net'

$baseAtlassianUrlApi ="$baseAtlassianUrl/rest/api/latest"
$filterUrl = "$baseAtlassianUrlApi/filter/12302"
$searchUrl = "$baseAtlassianUrlApi/search/?jql="

$basicAuthValue = "Basic $encodedCredentials"
$headers = @{ Authorization = $basicAuthValue }

$filterConfiguration = Invoke-WebRequest -Uri $filterUrl -Method Get -Headers $headers

$filterConfigurationJson = ConvertFrom-Json $filterConfiguration.Content
 $jqlQuery = $filterConfigurationJson.jql

$queryResults = Invoke-WebRequest -Uri "$searchUrl$jqlQuery" -Method Get -Headers $headers
$queryResultsJson = ConvertFrom-Json  $queryResults.Content

IF (  $queryResultsJson.total -lt 1)
{
    Write-Host "No items in the query. Cannot export to excel."
    return
}
Write-Host 'Reading data'
$dataToExport = ($queryResultsJson.issues |   Foreach-object { 
       ( New-Object -TypeName PSObject -Property @{
            Key       =  "https://trintech.atlassian.net/browse/$($_.key)"
            Summary        =   $_.fields.summary   
            Assignee      = $_.fields.assignee.name
            Priority      = $_.fields.priority.name
            IssueType      = $_.fields.issuetype.name
        })| Select-Object    Key , Summary, Assignee  ,Priority , IssueType

 }) 
Write-Host 'Exporting to excel'
$excelFileName ='C:\Temp\Demo.xlsx'
$dataToExport  | Export-XLSX -Path $excelFileName -Verbose -Force -Table -TableStyle Light9 

# $excelFile = New-Excel  -Path  $excelFileName -Verbose

# $excelFile  | Add-Table -TableStyle Light9 -Verbose -StartRow 1 -StartColumn 1 -

Write-Host 'Formatting excel'
#$excelFile | 
  #  Get-WorkSheet |  
    
        # Format-Cell -WrapText  $True    
        

#$excelFile | 
#    Get-WorkSheet |         
#        Format-Cell -Header  -Bold  $True  -Color White -BackgroundColor DarkBlue 
#$excelFile  | Save-Excel -Passthru
start "$excelFileName "
# Export-XLSX -Path $excelFileName -Verbose -Force -InputObject $dataToExport 
   