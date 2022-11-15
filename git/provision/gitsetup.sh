gitlab_rails['ldap_enabled'] = true
#gitlab_rails['prevent_ldap_sign_in'] = false

###! **remember to close this block with 'EOS' below**
gitlab_rails['ldap_servers'] = YAML.load <<-'EOS'
 main: # 'main' is the GitLab 'provider ID' of this LDAP server
   label: 'LDAP'
   host: 'a4ldc01.msx.local'
   port: 389
   uid: 'sAMAccountName'
   bind_dn: 'CN=Administrator,CN=Users,DC=msx,DC=local'
   password: 'msx@9797'
   encryption: 'plain' # "start_tls" or "simple_tls" or "plain"
   verify_certificates: true
   smartcard_auth: false
   active_directory: true
   allow_username_or_email_login: false
   block_auto_created_users: false
   base: 'CN=Users,DC=msx,DC=local'
#   user_filter: '(memberOf=CN=gitlab_users,OU=Groups,DC=msx,DC=local)'
EOS

