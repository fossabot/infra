include_recipe 'nodejs'

directory "#{node['common']['home']}/webapp" do
  user node['common']['user']
  group node['common']['group']
  mode '0775'
end

config = data_bag_item('config', 'webapp')[node.chef_environment]
env_file_content = ''
config.each do |k,v|
  env_file_content += "#{k.upcase}=#{v}\n"
end

env_file = "#{node['common']['home']}/webapp/env"
file env_file do
  content env_file_content
  owner node['common']['user']
  group node['common']['group']
  mode '0664'
  notifies :restart, 'systemd_unit[webapp.service]', :immediate
end

systemd_unit 'webapp.service' do
  content <<~EOF
    [Unit]
    Description=devlover.id webapp
    After=network.target

    [Service]
    Type=simple
    User=#{node['common']['user']}
    WorkingDirectory=/home/#{node['common']['user']}/webapp/current
    EnvironmentFile=#{env_file}
    ExecStart=/usr/local/bin/npm start
    Restart=on-failure

    [Install]
    WantedBy=multi-user.target
  EOF

  action [:create, :enable, :start]
  verify false
end

sudo "#{node['common']['user']}_webapp" do
  user node['common']['user']
  nopasswd true
  commands [
    '/bin/systemctl restart webapp.service',
    '/bin/systemctl start webapp.service',
    '/bin/systemctl stop webapp.service',
    '/bin/systemctl status webapp.service'
  ]
end
