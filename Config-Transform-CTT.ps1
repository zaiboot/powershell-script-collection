# Config-Transform-CTT
$cttToolPath = 'c:\tools\ctt\ctt.exe'
$emsSourcePath = 'C:\Users\emadrigal\projects\Certification\EMS'
$sourceConfigFile = "$emsSourcePath\log4net.config"
$transformConfigFile = "$emsSourcePath\log4net.debug.config"
$outputConfigFile = "$emsSourcePath\log4net.output.config"

& "$cttToolPath preservewhitespace s:$sourceConfigFile t:$transformConfigFile d:$outputConfigFile"