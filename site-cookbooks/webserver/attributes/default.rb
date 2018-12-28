default['nginx']['default_site_enabled'] = false
default['nginx']['user'] = default['common']['user']
default['nginx']['group'] = default['common']['group']
default['nginx']['error_log_options'] = 'warn'
default['nginx']['keepalive'] = 'on'
default['nginx']['keepalive_requests'] = 10000
default['nginx']['keepalive_timeout'] = 30
default['nginx']['worker_processes'] = 'auto'
default['nginx']['worker_connections'] = 10000
default['nginx']['worker_rlimit_nofile'] = 200000
default['nginx']['server_tokens'] = 'off'
default['nginx']['client_body_buffer_size'] = '256k'
default['nginx']['client_max_body_size'] = '10m'
default['nginx']['gzip'] = 'on'
default['nginx']['gzip_comp_level'] = 7
default['nginx']['gzip_min_length'] = 256
default['nginx']['gzip_proxied'] = 'expired no-cache no-store private auth'
default['nginx']['gzip_types'] = ['text/plain', 'text/css', 'text/xml', 'text/javascript', 'application/x-javascript', 'application/json', 'application/xml']
default['nginx']['gzip_disable'] = 'msie6'
default['nginx']['status']['port'] = 8888
default['nginx']['extra_configs'] = {
  'open_file_cache' => 'max=200000 inactive=20s',
  'open_file_cache_valid' => '30s',
  'open_file_cache_min_uses' => 2,
  'open_file_cache_errors' => 'on',
  'client_header_buffer_size' => '256k',
  'large_client_header_buffers' => '10 256k',
  'client_body_timeout' => '30s',
  'client_header_timeout' => '30s',
}

# root to do acme challenge
default['nginx']['acme_challenge']['dir'] = '/var/www/acme_validation'
