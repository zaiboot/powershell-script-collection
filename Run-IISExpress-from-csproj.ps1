#Run-IISExpress-from-csproj.ps1
clear
$projectBasePath = "$env:UserProfile\projects\userManagement\userManagement.API\"
$csprojFilePath = "$projectBasePath\UserManagement.API.csproj"

$xpath = " /Project/ProjectExtensions/VisualStudio/FlavorProperties/WebProjectProperties/AutoAssignPort"

[xml] $csprojXml = cat $csprojFilePath
$port  = $csprojXml.SelectSingleNode($xpath)
Write-Host $port
#start IISExpress 
Write-Host "$env:ProgramFiles\IIS Express\iisexpress" ,  "   /path:$projectBasePath  /port:$port /clr:v4.6.1"
& "$env:ProgramFiles\IIS Express\iisexpress" "/path:$projectBasePath  /port:$port /clr:v4.6.1"