directory "#{node['common']['home']}/api" do
  user node['common']['user']
  group node['common']['group']
  mode '0775'
end

config = data_bag_item('config', 'api')[node.chef_environment]
env_file_content = ''
config.each do |k,v|
  env_file_content += "#{k.upcase}=#{v}\n"
end

env_file = "#{node['common']['home']}/api/env"
file env_file do
  content env_file_content
  owner node['common']['user']
  group node['common']['group']
  mode '0664'
  notifies :restart, 'systemd_unit[api.service]', :immediate
end

systemd_unit 'api.service' do
  content <<~EOF
    [Unit]
    Description=devlover.id api
    After=network.target

    [Service]
    Type=simple
    User=#{node['common']['user']}
    WorkingDirectory=/home/#{node['common']['user']}/api/current
    EnvironmentFile=#{env_file}
    ExecStart=/home/#{node['common']['user']}/api/current/api
    Restart=on-failure

    [Install]
    WantedBy=multi-user.target
  EOF
  action [:create, :enable, :start]
  verify false
end

sudo "#{node['common']['user']}_api" do
  user node['common']['user']
  nopasswd true
  commands [
    '/bin/systemctl restart api.service',
    '/bin/systemctl start api.service',
    '/bin/systemctl stop api.service',
    '/bin/systemctl status api.service'
  ]
end
