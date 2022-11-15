$dmode = "WinThreshold"
$fmode = "WinThreshold"
$dnetbioname = "MSX"
$dname = "msx.local"
$vadapter = "Ethernet"
$dadapter = "Ethernet 2"

#set administrator account password
net user administrator msx@9797 

#Setup the server as a domain controller
$Password = "msx@9797" | ConvertTo-SecureString -AsPlainText -Force

Install-WindowsFeature AD-Domain-Services -IncludeManagementTools

Import-Module ADDSDeployment

Install-ADDSForest -SafeModeAdministratorPassword $Password -CreateDnsDelegation:$false -DomainMode $dmode -DomainName $dname -DomainNetbiosName $dnetbioname -ForestMode $fmode -InstallDns:$true -NoRebootOnCompletion:$false -Force:$true


