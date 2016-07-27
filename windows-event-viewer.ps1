Get-WinEvent -FilterHashtable @{ProviderName='nssm';logname='Application'} -MaxEvents 10 | ft -wrap


$dev6Information =  $(Get-WmiObject win32_service | ?{$_.Name -like '*Intellicus*P*Dev6'} | SELECT *)
$dev20_sp1Information = $(Get-WmiObject win32_service -Verbose | ?{$_.Name -like '*Intellicus*P*Dev20_2'} | SELECT *)

Compare-Object -ReferenceObject $dev6Information[0]  -DifferenceObject $dev20_sp1Information[0]