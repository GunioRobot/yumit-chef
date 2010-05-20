require 'rubygems'
require 'json'

dna = {
  :host => {
    :hostname => 'server',
    :domain => 'yumit.com',
    :ipaddress => '79.125.12.4'
  },

  :ebs_volumes => [
    {:device => 'sdf', :path => '/db'},
    {:device => 'sdg', :path => '/www'}
  ],

  :ec2_settings => {
    :public_key => 'AKIAJVM2GAYDRCVWVKEA',
    :private_key => 'hFrwOAGjnZp7IYiFgw0Q7OsjcE4zwkspoVczTDnH',
    :zone => 'eu-west-1'
  },

  :snapshots => {
    'sdf' => {
      'minute' => 48,
      'hour' => 15
    },
    'sdg' => {
      'minute' => 48,
      'hour' => 15
    }
  },

  :mysql => {
    :datadir => '/var/lib/mysql',
    :ec2_path => '/db/mysql',
    :server_root_password => 'belen3',
    :tunable => {
      :max_connections => 100,
      :key_buffer => '40M',
      :net_read_timeout => 30,
      :max_heap_table_size => "256MB"
    },
  },

  :sphinx => {
    :prefix => '/usr/local'
  },

  :apache => {
    :contact => 'jorgedf@yumit.com',
    :listen_ports => ['8080']
  },
  
  :squid => {
    :cache_dir => '/var/cache/squid'
  },

  :passenger => {
    :version => '2.2.9',
    :max_pool_size => 12,
    :stat_throttle_rate => 10
  },

  :rails => {
    :version => '2.3.5'
  },

  :packages => [
    'imagemagick',
    'htop',
    'git-core'
  ],

  :users => [{
    :username => 'capistrano',
    :authorized_keys => "ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEAw5b4okzvmo9TKfqz6zAP4Y38xnBN4UIGfbOO8OrrD9YPOBQiEd8RAvPrZ/oxTSutxABqEtUDowBa36WlRkGX9OVUvwXj+yec5BaBGPk4mqp+7YZJSeKhOrrWKVr43q9uNDxuChJD1+MwME6HnE/RvONPpF8OKEEfkYqd1GmxwGIMhgNK47MsK1lwAG06+5oMv6HySUWxMgoG25BaxK2+0Y77WDUqgaIwnymgOZekBPdPnixP8C4cWqH2gD/HNikVVOEd2gvztsMGbDfAiIkc/ryqcT3SM9ES565qKPsY5ZpDQfXsdl6RMwtwATOg3vLi9OBW4CaaDgIOBwfGppH3Vw== mbc@mbcbook.local\n" +
                        "ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEAsaBcf6co1Z60Pl57IfoAB20Y1xfWVdw7F2vmKZC83byw1XdQSoUTarkcPOYoFMvAUfTlCGaj4Fn1RTOdvNAIs/p3b6TdZiiEvmIKcpFKoh31Gvul0SbJli279eLm7QxztAz9xTtXbprPAyZdUdkFMQ4TOeJf1nl/Mv8qUvvTQJHn5d+sLW3lPMAbDoPijkSTV9B3H4G0WhHvWmyTNaWVjng68xeEEKFA+d/l8G6AZyFhc7FtryNfpPOV3svahd6kGCDPohphUDAqQX+cJKRmbLJ6VgZhbnAOQQmBoU2QPkp2+0AEmdheIgeuH+B+/ngp0ZlSRmTG1LwZtWAPYqvjSw== xurde@Macintosh.local",
    :gid => 4001,
    :uid => 4001
  }],

  :groups => [{
    :name => 'www-data',
    :members => ['www-data', 'capistrano']
  }],

  :yumit => {
    :dir => '/www/yumit',
    :server_name => 'yumit.com',
    :server_aliases => ['www.yumit.com'],
    :user => 'capistrano',
    :db => {
      :name => 'yumitdb',
      :user => 'root',
      :password => 'belen3',
      :host => 'localhost'
    }
  },
  
  :squid => {
    :cache_dir => '/var/cache/squid'
  },

  :postfix => {
    :smtp_use_tls => 'no',
    :mydomain     => 'yumit.com'
  },

  :motd => "Welcome to the Yumit EC2 web server instance.\n\n" +
           "This instance is managed by chef. Access by ssh should never be used\n" +
           "to install packages, change configuration files or manually compile\n"  +
           "libraries. All of these tasks should be handled through changing the\n" +
           "central chef recipe.\n",

  :recipes => [
    'host',
    'sources',
    'tasksel',
    'apparmor',
    'motd',
    'ec2-ebs',
    'snapshots',
    'packages',
    'mysql::server',
    'squid',
#    'sphinx',
    'users',
    'groups',
    'postfix',
    'squid',
    'yumit',
    'redis'
  ]
}

open(File.dirname(__FILE__) + "/dna.json", "w").write(dna.to_json)
