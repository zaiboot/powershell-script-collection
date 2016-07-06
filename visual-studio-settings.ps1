function Set-Registry-Value($path, $value, $propertyType)
{
    if ( Test-Path -Path $path ){
                
    }
}

#Basic settings
$VS_REGISTRY_PATH = "HKCU:\Software\Microsoft\VisualStudio\14.0\"
$PROJECTS_PATH =  '%USERPROFILE%\projects'
Set-ItemProperty -path $VS_REGISTRY_PATH  -value $PROJECTS_PATH  -name 'DefaultOpenProjectLocation'
Set-ItemProperty -path $VS_REGISTRY_PATH  -value $PROJECTS_PATH  -name 'DefaultOpenSolutionLocation'

$VS_BASIC_TEXT_EDITOR = "$VS_REGISTRY_PATH\Text Editor\Basic" 
Set-ItemProperty -path $VS_BASIC_TEXT_EDITOR  -value 4  -name 'Tab Size'
Set-ItemProperty -path $VS_BASIC_TEXT_EDITOR  -value 1  -name 'Line Numbers' #TRUE

$VS_DEBUGGER ="$VS_REGISTRY_PATH\Debugger\"
New-ItemProperty -path $VS_BASIC_TEXT_EDITOR  -value 1  -name 'DisableAttachSecurityWarning' -PropertyType DWORD


IF ( (Get-ItemProperty  -Path 'HKCU:\Software\Microsoft\VisualStudio\14.0\Debugger\'  -Name D*).Length -gt 0 )
{
    Write-Host "yeah"
}else{
    Write-Host "lenght = " +  (Get-ItemProperty  -Path 'HKCU:\Software\Microsoft\VisualStudio\14.0\Debugger\'  -Name D*).Length
}

(Get-ItemProperty  -Path 'HKCU:\Software\Microsoft\VisualStudio\14.0\Debugger\'  -Name D*).Name