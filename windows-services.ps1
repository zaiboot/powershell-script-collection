#windows-services.ps1
Get-Service # list all of the services.

Get-Service w* #Search services by name

# very obvious
Start-Service  -Name Tomcat 
Stop-Service
Restart-Service

# service management
New-Service 
(Get-WmiObject win32_service -Filter "name='TestService'").delete()  #delete a service
Set-Service