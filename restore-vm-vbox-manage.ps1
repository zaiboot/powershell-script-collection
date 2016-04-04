#Restore VM from MS
$VBoxManage =$env:ProgramFiles+ "\Oracle\VirtualBox\VBoxManage.exe"
$pathToTheVM=$env:UserProfile+"\Downloads\IE11.Win7.For.Windows.VirtualBox\IE11 - Win7.ova"
$vmName = "IE11-Win7"
& $VBoxManage import $pathToTheVM --vsys 0 --unit 4 --ignore --vsys 0 --vmname $vmName