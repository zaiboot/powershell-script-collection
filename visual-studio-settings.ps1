#Basic settings
$VS_REGISTRY_PATH = "HKCU:\Software\Microsoft\VisualStudio\14.0\"
$PROJECTS_PATH =  '%USERPROFILE%\projects'
Set-ItemProperty -path $VS_REGISTRY_PATH  -value $PROJECTS_PATH  -name 'DefaultOpenProjectLocation'
Set-ItemProperty -path $VS_REGISTRY_PATH  -value $PROJECTS_PATH  -name 'DefaultOpenSolutionLocation'