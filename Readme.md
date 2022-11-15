---------------IMP-----------------

Refer to Lab_Setup.png file to check the lab configuration.

-------------How-To----------------

Start the VMs in the following order to avoid any connectivity issues.

1. Domain Controller
2. Puppet Master
3. Prometheus Server
4. Rest of the VMs

Domain name used for setting up the lab is msx.local. This can be changed by the command

<sudo sed -i 's|msx|newdomain|g'> script_name 

<sudo sed -i 's|MSX|NEWDOMAIN|g'> script_name

The above command assumes that the new domain ends with .local suffix. Please modify the command accordingly incase you want to change the domain suffix.
This command needs to be run for all the scripts present in /data folder. 

The default password used for the lab is msx@9797, except for the default configs of gitlab, jenkins and grafana.

The scripts present in /vagrant_scripts can be used to run vagrant commands from anywhere, just modify your VM path accordingly.
These scripts just 'cd' to the vagrant directory and run the commands, nothing fancy.


