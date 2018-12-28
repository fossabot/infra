config = data_bag_item('config', 'database')[node.chef_environment]

postgresql_server_install 'install postgresql' do
  action :install
  version node['database']['version']
end

postgresql_server_install 'init postgresql cluster' do
  action :create
  password config['postgres_password']
end

postgresql_database config['name'] do
  owner 'postgres'
  locale 'en_US.utf8'
  template 'template0'
end

[config['api']].each do |user|
  postgresql_user user['username'] do
    login true
    encrypted_password user['password']
    sensitive false
  end

  postgresql_access "db access for #{user['username']}" do
    access_type 'host'
    access_db config['name']
    access_user user['username']
    access_addr '0.0.0.0/0'
    access_method 'md5'
  end
end
