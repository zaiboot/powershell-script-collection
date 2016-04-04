# call .sql file
# check: https://msdn.microsoft.com/en-us/library/cc281720.aspx

$ServerInstance = "(local)"
$ScriptPath = $env:UserProfile+"\"
$filePath = "$ScriptPath\file.sql"
$databaseName = "demo"
Invoke-Sqlcmd -InputFile $filePath -Database $databaseName | out-null