include_recipe 'nginx::default'
include_recipe 'nginx::http_stub_status_module'
include_recipe 'acme::default'

template '/etc/nginx/conf.d/acme_validation.inc' do
  source 'acme_validation.inc.erb'
  owner 'root'
  group 'root'
  mode '0775'
  notifies :restart, 'service[nginx]', :immediate
end

directory node['nginx']['acme_challenge']['dir'] do
  recursive true
  owner node['common']['user']
  group node['common']['group']
  mode '0770'
end

execute 'create dhparam' do
  command 'openssl dhparam -dsaparam -out /etc/nginx/dhparam.pem 2048'
  not_if { ::File.exists?('/etc/nginx/dhparam.pem') }
end

['ssl.inc', 'security.inc', 'proxy.inc'].each do |item|
  cookbook_file "/etc/nginx/conf.d/#{item}" do
    source item
    owner 'root'
    group 'root'
    mode '0664'
  end
end

# create ssl certificates dir
directory "#{node['common']['home']}/certs" do
  recursive true
  owner node['common']['user']
  group node['common']['group']
  mode '0770'
end

['webapp', 'api'].each do |site|
  config = data_bag_item('config', site)[node.chef_environment]
  webserver_ssl_site config['domain'] do
    action :create
    upstream_listen_addr config['listen_addr']
  end
end
