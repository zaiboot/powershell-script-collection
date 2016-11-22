#Tweak-Config-Files
clear
$baseFolder = $env:USERPROFILE  + '\projects\Certification\EMS'


$wildcards = 'App.config'

(ls -Path $baseFolder -Filter $wildcards -Recurse -File ).FullName| % { 

        Write-Progress  -Activity "Updating $_" 
        
        [xml]  $configFile = gc $_
        $log4NetConfig =  $configFile.SelectSingleNode('/configuration/log4net')
        
        if ( $log4NetConfig )  {  
        
            # $configFile.SelectSingleNode('/configuration').RemoveChild($log4NetConfig  )  | Out-Null
            $log4NetConfig.RemoveAll()
            $appSettinglog4net =  $configFile.SelectSingleNode("/configuration/appsettings/add[key='log4net.Config']")

            if (!$appSettinglog4net) {
                $appSettinglog4net = $configFile.CreateElement("add")                            
                $configFile.configuration.appSettings.AppendChild($appSettinglog4net)
            }
            
            $appSettinglog4net.SetAttribute('key','log4net.Config')
            $appSettinglog4net.SetAttribute('value','..\log4net.Config')
            $configFile.Save($_)
            
        }

        

} 
