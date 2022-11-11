gitlab_rails['ldap_enabled'] = true

###! **remember to close this block with 'EOS' below**
gitlab_rails['ldap_servers'] = YAML.load <<-'EOS'
 main: # 'main' is the GitLab 'provider ID' of this LDAP server
  label: 'Active Directory Login'
  host: 'a4ldc01.animals4life.local'
  port: 389
  uid: 'sAMAccountName'
  method: 'plain' # "tls" or "ssl" or "plain"
  bind_dn: 'CN=Administrator,CN=Users,DC=animals4life,DC=local'
  password: 'msx@9797'
  active_directory: true
  allow_username_or_email_login: false
  block_auto_created_users: false
  base: 'CN=Users,DC=animals4life,DC=local'
  timeout: 10
  user_filter: '(memberOf=CN=gitlab_users,OU=Groups,DC=animals4life,DC=local)'
EOS

