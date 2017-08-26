#Find-AppPool-pid
clear
Invoke-Command -ComputerName "dalqahvs82"  -ScriptBlock {
    #Import-Module WebAdministration
    #Get-ChildItem –Path IIS:\AppPools\*qa82-280*  | Get-Member
    $env:Path += ';' + $env:windir +'\system32\inetsrv\'
    appcmd list wps
}