#Basic settings
clear
$VS_REGISTRY_PATH = "HKCU:\Software\Microsoft\VisualStudio\14.0\"
$PROJECTS_PATH =  '%USERPROFILE%\projects'
Set-ItemProperty -path $VS_REGISTRY_PATH  -value $PROJECTS_PATH  -name 'DefaultOpenProjectLocation'
Set-ItemProperty -path $VS_REGISTRY_PATH  -value $PROJECTS_PATH  -name 'DefaultOpenSolutionLocation'

$VS_BASIC_TEXT_EDITOR = "$VS_REGISTRY_PATH\Text Editor\Basic" 
Set-ItemProperty -path $VS_BASIC_TEXT_EDITOR  -value 4  -name 'Tab Size'
Set-ItemProperty -path $VS_BASIC_TEXT_EDITOR  -value 1  -name 'Line Numbers' 

$VS_DEBUGGER ="$VS_REGISTRY_PATH\Debugger\"
New-ItemProperty -path $VS_DEBUGGER  -value 1  -name 'DisableAttachSecurityWarning' -PropertyType DWORD -Force 