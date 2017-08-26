$nugetBasePath = "$env:userProfile\.nuget\packages"
$openCoverPath = "$nugetBasePath\opencover\4.6.519\tools\OpenCover.Console.exe"

$xunitConsolePath = "$nugetBasePath\.nuget\packages\xunit.runner.console\2.2.0\tools\xunit.console.exe"
$baseXmlOutput = 'C:\CodeProject\SampleXunit.Test\coverage.xml'
$testsToRun = ls *.Tests.dll -R -File |  Where-Object{(!$_.FullName.Contains('\obj\') )} 
$openCoverPath -output:"$baseXmlOutput" -target:"$xunitConsolePath" -targetargs:""$testsToRun "" /noshadow" -register:user -filter:+[*]* C:\CodeProject\packages\ReportGenerator.1.9.1.0\reportgenerator C:\CodeProject\SampleXunit.Test\coverage.xml C:\CodeProject\SampleXunit.Test\coverage
start C:\CodeProject\SampleXunit.Test\coverage\index.htm
clear
cd "C:\Users\Edgar\projects\reportingapi\Reporting.DAL.Tests"


$openCoverPath
-target:"C:\Users\[USERNAME]\.dnx\runtimes\dnx-clr-win-x86.1.0.0-rc1-update1\bin\dnx.exe"
-targetargs:"--lib C:\ASPNET\UnitTestDemo\src\Math\bin\Debug\dnx451 test"
-output:coverage.xml
-register:user
-filter:"+[*]* -[xunit*]*"