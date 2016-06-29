#Restore VM from MS
$VBoxManage =$env:ProgramFiles+ "\Oracle\VirtualBox\VBoxManage.exe"
$pathToTheVM=$env:UserProfile+"\Downloads\IE11.Win7.For.Windows.VirtualBox\IE11 - Win7.ova"
# unit 4: Sound card "" -- disabled
& $VBoxManage import $pathToTheVM --vsys 0 --unit 4 --ignore --vmname IE11-Win7v2
& $VBoxManage modifyvm "IE11-Win7v2" --nic1 bridged --bridgeadapter1 eth0
#looks like the units of each one are not standardize. Unit 4  could be anything, from sound card to RAM disk