# call migration script file
# check: https://msdn.microsoft.com/en-us/library/cc281720.aspx

$ServerInstance = "(local)"
$ScriptPath = $env:UserProfile+"\projects\Certification\Database\DBScript"
$filePath = "$ScriptPath\Certification_Upgrade_DBScript_2.7.0.0 to 2.8.0.0.sql"
$databaseName = "Certification"
Invoke-Sqlcmd -InputFile $filePath -Database $databaseName | out-null