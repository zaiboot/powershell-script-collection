#Install-Package logentries.core -Version 2.8.0
#Install-Package logentries.log4net -Version 2.8.0

#Tweak-Config-Files

function Add-Package {
    [cmdletbinding()]
    Param (
        [string] $filePath,        
        [string] $destination,
        [hashtable[]] $attributes
        )

    [xml] $packageFile = gc $filePath
    
    
    $attributes | % {
        $att = $_
        $package = $packageFile.CreateElement('package')
        $att.Keys | % {
        
            $package.SetAttribute($_, $att[$_])        
    
        }
        $packageFile.SelectSingleNode($destination).AppendChild($package) | Out-Null
    }
    
    $packageFile.Save($filePath)

}

Function Add-Csproj-Reference{
    [cmdletbinding()]
    Param (
        [string] $csprojFile,        
        [hashtable[]] $references
        )

        [xml] $csproj  =  gc $csprojPath
        $references1 = $csproj.Project.ItemGroup.Reference
        

        $references | % {

            $referenceInCsproj = $csproj.CreateElement('Reference', $csproj.Project.NamespaceURI)
            
                
            $referenceInCsproj.SetAttribute('Include', $_['Include'] )
            
            
            $hintPath = $csproj.CreateElement('HintPath', $csproj.Project.NamespaceURI)
            $hintPath.InnerText = $_['HintPath']
            $referenceInCsproj.AppendChild( $hintPath ) | Out-Null

            $privateReference = $csproj.CreateElement('Private', $csproj.Project.NamespaceURI)
            $privateReference.InnerText = "True"

            $referenceInCsproj.AppendChild( $privateReference ) | Out-Null

            $references1.ParentNode.AppendChild($referenceInCsproj) | Out-Null
        
        }

        $csproj.Save($csprojPath)
        

}

clear
cd ~
$baseFolder = $env:USERPROFILE  + '\projects\CadencyService\'


$wildcards = 'App.config'


(ls -Path $baseFolder -Filter $wildcards -Recurse -File ).FullName| % { 

        Write-Progress  -Activity "Updating $_" 
        
        [xml]  $configFile = gc $_
        $log4NetConfig =  $configFile.SelectSingleNode('/configuration/log4net')

        if ( $log4NetConfig )  {
            
            cd ($_ -replace 'App.config', '')
            
            $ls = (ls *.csproj )
            #if ($ls.Count -lt 1) {
            # pwd
            #}

            $csprojPath = (ls *.csproj)[0].FullName

            Add-Csproj-Reference -csprojFile  $csprojPath -references @(
            @{    Include = 'LogentriesCore, Culture=neutral, processorArchitecture=MSIL'; HintPath = '..\..\Packages\logentries.core.2.8.0\lib\net40\LogentriesCore.dll' },
            @{    Include = 'LogentriesLog4net, Culture=neutral, processorArchitecture=MSIL'; HintPath = '..\..\Packages\logentries.log4net.2.8.0\lib\net40\LogentriesLog4net.dll' },
            @{    Include = 'Microsoft.WindowsAzure.Configuration, Version=3.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35, processorArchitecture=MSIL'; HintPath = '..\..\Packages\Microsoft.WindowsAzure.ConfigurationManager.3.1.0\lib\net40\Microsoft.WindowsAzure.Configuration.dll' }
            
                                            )

            $appConfigPath = (gci packages.config)[0].FullName
            
            Add-Package -filePath $appConfigPath -destination '/packages'  -attributes @(
            @{    id = 'logentries.core'; version = '2.8.0'; targetFramework = 'net40'}, 
            @{    id = 'logentries.log4net'; version = '2.8.0'; targetFramework = 'net40'}, 
            @{    id = 'Microsoft.WindowsAzure.ConfigurationManager'; version = '3.1.0'; targetFramework = 'net40'}
                                            )
            
            
        }


} 