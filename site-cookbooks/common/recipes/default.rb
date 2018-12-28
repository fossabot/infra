user node['common']['user'] do
  action :create
  comment 'Used to run applications'
  home node['common']['home']
  shell '/bin/bash'
end

group node['common']['group'] do
  action :create
  members node['common']['user']
end

directory node['common']['home'] do
  action :create
  owner node['common']['user']
  group node['common']['group']
  mode '0740'
end

limits_config node['common']['user'] do
  limits [
    { domain: node['common']['user'], type: 'hard', item: 'nofile', value: 500000 },
    { domain: node['common']['user'], type: 'soft', item: 'nofile', value: 500000 },
    { domain: node['common']['user'], type: 'hard', item: 'nproc', value: 500000 },
    { domain: node['common']['user'], type: 'soft', item: 'nproc', value: 500000 },
  ]
end

limits_config 'system-wide limits' do
  limits [
    { domain: '*', type: 'hard', item: 'nofile', value: 500000 },
    { domain: '*', type: 'soft', item: 'nofile', value: 500000 },
    { domain: '*', type: 'hard', item: 'nproc', value: 500000 },
    { domain: '*', type: 'soft', item: 'nproc', value: 500000 },
  ]
  use_system true
end

node['common']['sysctl_tweaks'].each do |k, v|
  sysctl_param k do
    value v
    ignore_error true
  end
end

directory "#{node['common']['home']}/.ssh" do
  owner node['common']['user']
  group node['common']['group']
  mode '0700'
end

file "#{node['common']['home']}/.ssh/authorized_keys" do
  owner node['common']['user']
  group node['common']['group']
  mode '0600'
end

node['common']['authorized_keys'].each do |key|
  append_if_no_line 'authorized_keys' do
    path "#{node['common']['home']}/.ssh/authorized_keys"
    line key
  end
end
