default['common']['user'] = 'bejo'
default['common']['group'] = 'bejo'
default['common']['home'] = '/home/bejo'
default['common']['sysctl_tweaks'] = {
  'net.ipv4.neigh.default.gc_thresh1' => 8096,
  'net.ipv4.neigh.default.gc_thresh2' => 12288,
  'net.ipv4.neigh.default.gc_thresh3' => 16384,
  'net.ipv4.ip_local_port_range' => '1024 65000',
  'net.ipv4.tcp_tw_reuse' => 1,
  'net.ipv4.tcp_fin_timeout' => 15,
  'net.core.somaxconn' => 4000,
  'net.core.netdev_max_backlog' => 10000,
  'net.core.rmem_max' => 16777216,
  'net.core.wmem_max' => 16777216,
  'net.ipv4.tcp_max_syn_backlog' => 20480,
  'net.ipv4.tcp_max_tw_buckets' => 400000,
  'net.ipv4.tcp_no_metrics_save' => 1,
  'net.ipv4.tcp_rmem' => '4096 87380 16777216',
  'net.ipv4.tcp_syn_retries' => 2,
  'net.ipv4.tcp_synack_retries' => 2,
  'net.ipv4.tcp_wmem' => '4096 65536 16777216',
  'net.ipv4.tcp_mem' => '50576 64768 98152',
  'net.netfilter.nf_conntrack_max' => 3921300,
  'net.ipv4.ip_nonlocal_bind' => 1,
  'net.ipv4.tcp_syncookies' => 1,
  'net.ipv4.tcp_sack' => 1,
  'net.ipv4.tcp_window_scaling' => 1,
  'net.ipv4.tcp_keepalive_intvl' => 30,
  'net.ipv4.tcp_moderate_rcvbuf' => 1,
  'fs.file-max' => 520000,
  'vm.swappiness' => 10,
}
default['common']['authorized_keys'] = [
  'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDWRDTkaVU7QmaxvXrv+/EIr0uyAzma+04C0nA0Kf9z9cwOtzSW/kLivv4KHMcLSfd5bgK/u97AVrZ+ff+bxOrwSs9H9VeCHZaLGgE6WT93Q8q5VKyak93Ks2eAzgFxqPLFc2Brz2HKXmayOot1wfGQL8c61b0ck+XdDgZdgLjAhTlsUNexSCRjZzMIFVce6YDFYlwZSKU+qOenSFtQvtev7WgCz7Xn1PR55Kah0Qkoa24100UGz28cz575jIeBbw6qj233v0DxbvXmNTlqUDz49pvBTp1aWujCyIhm4uO5DmUiWH6M8nvkmbsR4iF3TaTCw69ja8xaVF/GpeSRWvj3 aku-aku@github',
  'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDEFQitpNnwcdCg749wjElBY5s4WTGWv3C13uGgNJnQU8H6KCI+spbBysK903JKyv9348ZuO8eJN6VTeGrd77nouW873qlr5jiMfZXAbuoAtVbZQvplYH+90gm/TIVtNFHJKj6LupI5jdnLupBfS3jaKEZAUEP0JiJI2UksHtPLQwToSBjs0wup1s9vaevh/t5ZUu04iDSTkryPeQ4OBcQhnzIwfOHRc7s8NCJGaDpKSdnduPNhGc+aZkuKWT4aDGqwHk4a6Sn1wyKwGDj1YoDUmbuD124XBRl/D7W9Dpd4XvmHT6RLpswRpUlIdP6Cxz3F+YuVfF5QKh+FXjiXC1ID api@github'
]
