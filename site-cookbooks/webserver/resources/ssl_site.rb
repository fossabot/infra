property :domain, String, name_property: true
property :upstream_listen_addr, String, required: true

default_action :create

action :create do
  acme_selfsigned new_resource.domain do
    action :create
    crt "#{node['common']['home']}/certs/#{new_resource.domain}.crt"
    key "#{node['common']['home']}/certs/#{new_resource.domain}.key"
    chain "#{node['common']['home']}/certs/#{new_resource.domain}.pem"
    owner node['common']['user']
    group node['common']['group']
    notifies :restart, 'service[nginx]', :delayed
  end

  nginx_site new_resource.domain do
    action :enable
    template 'proxied_site.erb'
    variables ({
      'upstream_listen_addr': new_resource.upstream_listen_addr,
      'domain': new_resource.domain
    })
    notifies :restart, 'service[nginx]', :delayed
  end

  # create dummy bundle certificate so nginx can run for acme validation
  file "#{node['common']['home']}/certs/#{new_resource.domain}.bundle" do
    content lazy {
      ::File.read("#{node['common']['home']}/certs/#{new_resource.domain}.crt")
    }
    owner node['common']['user']
    group node['common']['group']
    mode '0522'
    only_if { ! ::File.exists?("#{node['common']['home']}/certs/#{new_resource.domain}.bundle") }
  end

  acme_certificate new_resource.domain do
    action :create
    crt "#{node['common']['home']}/certs/#{new_resource.domain}.crt"
    key "#{node['common']['home']}/certs/#{new_resource.domain}.key"
    chain "#{node['common']['home']}/certs/#{new_resource.domain}.pem"
    owner node['common']['user']
    group node['common']['group']
    wwwroot node['nginx']['acme_challenge']['dir']
    notifies :restart, 'service[nginx]', :delayed
  end

  file "#{node['common']['home']}/certs/#{new_resource.domain}.bundle" do
    content lazy {
      ::File.read("#{node['common']['home']}/certs/#{new_resource.domain}.crt") + ::File.read("#{node['common']['home']}/certs/#{new_resource.domain}.pem")
    }
    owner node['common']['user']
    group node['common']['group']
    mode '0522'
    notifies :restart, 'service[nginx]', :delayed
  end
end
