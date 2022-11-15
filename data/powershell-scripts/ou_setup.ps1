
Import-Module activedirectory

#convert password string to secure.string 
$password="msx@9797"
$securepassword = ConvertTo-SecureString $password -AsPlainText -Force

#Create OU -- Groups
New-ADOrganizationalUnit -Name "Groups" -Path "DC=msx,DC=local"

#Create linux_users, linux_admins, gitlab_users groups in AD
New-ADGroup -Name "linux_users" -SamAccountName linux_users -GroupCategory Security -GroupScope Global -DisplayName "Linux Users" -Path "OU=Groups,DC=msx,DC=local" -Description "Members of this group can login the on linux servers"

New-ADGroup -Name "linux_admins" -SamAccountName linux_admins -GroupCategory Security -GroupScope Global -DisplayName "Linux Administrators" -Path "OU=Groups,DC=msx,DC=local" -Description "Members of this group can run all the commands on linux servers and act as Administrators"

New-ADGroup -Name "gitlab_users" -SamAccountName gitlab_users -GroupCategory Security -GroupScope Global -DisplayName "Gitlab Users" -Path "OU=Groups,DC=msx,DC=local" -Description "Members of this group can login to a4l-git.msx.local Gitlab code repository"

#Create users in AD

New-ADUser -Name "Clark Kent" -EmailAddress "mandeepsinghlaller+superman@gmail.com"-SamAccountName "super.man" -Accountpassword $securepassword -Path "CN=Users,DC=msx,DC=local" -ChangePasswordAtLogon $False -PasswordNeverExpires $true -Enabled $true

New-ADUser -Name "Mandeep Singh" -EmailAddress "mandeepsinghlaller@gmail.com"-SamAccountName "mandeep.s" -Accountpassword $securepassword -Path "CN=Users,DC=msx,DC=local" -ChangePasswordAtLogon $False -PasswordNeverExpires $true -Enabled $true

New-ADUser -Name "Bruce Wayne" -EmailAddress "mandeepsinghlaller+batman@gmail.com" -SamAccountName "bat.man" -Accountpassword $securepassword -Path "CN=Users,DC=msx,DC=local" -ChangePasswordAtLogon $False -PasswordNeverExpires $true -Enabled $true

New-ADUser -Name "Peter Parker" -EmailAddress "mandeepsinghlaller+spiderman@gmail.com" -SamAccountName "spider.man" -Accountpassword $securepassword -Path "CN=Users,DC=msx,DC=local" -ChangePasswordAtLogon $False -PasswordNeverExpires $true -Enabled $true

New-ADUser -Name "Tony Stark" -EmailAddress "mandeepsinghlaller+ironman@gmail.com" -SamAccountName "iron.man" -Accountpassword $securepassword -Path "CN=Users,DC=msx,DC=local" -ChangePasswordAtLogon $False -PasswordNeverExpires $true -Enabled $true

Add-ADGroupMember -Identity linux_users -Members bat.man,mandeep.s,super.man,iron.man,spider.man
Add-ADGroupMember -Identity linux_admins -Members bat.man,mandeep.s
Add-ADGroupMember -Identity gitlab_users -Members bat.man,mandeep.s
