#Requirements:
# * PSExcel : https://www.powershellgallery.com/packages/PSExcel 
clear
Import-Module PSExcel

function ConvertTo-Base64($string) {
	$bytes = [System.Text.Encoding]::UTF8.GetBytes($string);
	$encoded = [System.Convert]::ToBase64String($bytes);
	return $encoded;
}
$userName='edgar.madrigal'
$password=''
$encodedCredentials = ConvertTo-Base64("${userName}:${password}")


function GetFrom-Jira($url){ 
        Write-Host "Sending request to: $url"
        $basicAuthValue = "Basic $encodedCredentials"
        $headers = @{ Authorization = $basicAuthValue }
        $queryResults = Invoke-WebRequest -Uri $url -Method Get -Headers $headers
        return $queryResults
}

$baseAtlassianUrl = 'https://trintech.atlassian.net'
$baseAtlassianUrlApi ="$baseAtlassianUrl/rest/api/latest"
$searchUrl = "$baseAtlassianUrlApi/search/?jql="
 $jqlQuery =  'issuetype in (Bug, Escalation) AND Sprint = 159' #$filterConfigurationJson.jql
 $queryResults = GetFrom-Jira("$searchUrl$jqlQuery")
$queryResultsJson = ConvertFrom-Json  $queryResults.Content

IF (  $queryResultsJson.total -lt 1)
{
    Write-Host "No items in the query. Cannot export to excel."
    return
}
Write-Host 'Reading data'
$queryResults.Content > "c:\temp\results.txt"
$dataToExport = ($queryResultsJson.issues |   Foreach-object { 
        
        $issueKey = $_.key
        $changeLogUrl = "$baseAtlassianUrlApi/issue/$($issueKey)?expand=changelog"
        
        $changeLogResult  = GetFrom-Jira($changeLogUrl)
        $jsonResult = ConvertFrom-Json  $changeLogResult.Content

        $jsonResult.changelog.histories | where { $_.items | where { $_.to = "10203"}} | Write-Host $_


       ( New-Object -TypeName PSObject -Property @{
            Key       =  $issueKey
            Summary        =   $_.fields.summary   
            Assignee      = $_.fields.assignee.name
            Priority      = $_.fields.priority.name
            IssueType      = $_.fields.issuetype.name
        })| Select-Object    Key , Summary, Assignee  ,Priority , IssueType

 }) 
Write-Host 'Exporting to excel'
$excelFileName ='C:\Temp\Demo.xlsx'
# $dataToExport  | Export-XLSX -Path $excelFileName -Verbose -Force -Table -TableStyle Light9 

# $excelFile = New-Excel  -Path  $excelFileName -Verbose

# $excelFile  | Add-Table -TableStyle Light9 -Verbose -StartRow 1 -StartColumn 1 -

#$excelFile | 
  #  Get-WorkSheet |  
    
        # Format-Cell -WrapText  $True    
        

#$excelFile | 
#    Get-WorkSheet |         
#        Format-Cell -Header  -Bold  $True  -Color White -BackgroundColor DarkBlue 
#$excelFile  | Save-Excel -Passthru
#start "$excelFileName "
# Export-XLSX -Path $excelFileName -Verbose -Force -InputObject $dataToExport 
   
