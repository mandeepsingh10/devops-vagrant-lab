gitlab_rails['ldap_enabled'] = true
gitlab_rails['prevent_ldap_sign_in'] = false
gitlab_rails['ldap_servers'] = YAML.load <<-'EOS'
 main: 
     label: 'LDAP'
     host: 'a4ldc01.animals4life.local'
     port: 389
     uid: 'sAMAccountName'
     bind_dn: 'CN=Administrator,CN=Users,DC=animals4life,DC=local'
     password: 'msx@9797'
     encryption: 'plain' # "start_tls" or "simple_tls" or "plain"
     active_directory: true
     allow_username_or_email_login: false
     block_auto_created_users: false
     base: 'CN=Users,DC=animals4life,DC=local'
     timeout: 10
     user_filter: '(memberOf=CN=gitlab_users,OU=Groups,DC=animals4life,DC=local)'
EOS

