require 'rubygems'
require 'json'

dna = {
  :host => {
    :hostname => 'yumit20',
    :domain => 'yumit.com',
    :ipaddress => '50.16.172.198'
  },

  :ebs_volumes => [
    {:device => 'sdf', :path => '/db'},
    {:device => 'sdg', :path => '/www'}
  ],

  :ec2_settings => {
    :public_key => 'AKIAJS63XC3422OXLULA',
    :private_key => 'lcHhWq7AXPy75A5DFVwBp6LQlJp3MSZ+w7OUFKS2',
    :zone => 'us-east-1c'
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
    :contact => 'pablete@yumit.com',
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
    :authorized_keys => "ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEAsaBcf6co1Z60Pl57IfoAB20Y1xfWVdw7F2vmKZC83byw1XdQSoUTarkcPOYoFMvAUfTlCGaj4Fn1RTOdvNAIs/p3b6TdZiiEvmIKcpFKoh31Gvul0SbJli279eLm7QxztAz9xTtXbprPAyZdUdkFMQ4TOeJf1nl/Mv8qUvvTQJHn5d+sLW3lPMAbDoPijkSTV9B3H4G0WhHvWmyTNaWVjng68xeEEKFA+d/l8G6AZyFhc7FtryNfpPOV3svahd6kGCDPohphUDAqQX+cJKRmbLJ6VgZhbnAOQQmBoU2QPkp2+0AEmdheIgeuH+B+/ngp0ZlSRmTG1LwZtWAPYqvjSw== xurde@Macintosh.local\n"+
                        "ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEAziTPchyB5B0v+jFNTijHOZu/LL5cnpUbfCjA972O9BcW1OV+A4THXfpM4Rd4hYhaOUcIZyWp8tR1x96FiRs5bwtR0GraKrmMEg3en8RsxZc6HUZZhDK080WCGhWNDPRBf5018MVth+Ewm4nVbyy4cwxn9O6iIROFlX9vtk2eQoAuJkNSlW9mFXXUOT+FY5HUkznQ2ctOXlcKYHJCsvFLKanfIEQXvHT81X1UJJs7iArF2Tddjj/sN6dZx5CrTjGph2mHz6upENzZTdz844++S45h/oPblXnnlu+puv1k6ALhMPdEVMqFY5jOxfWzkJG6wfXplyTFYiL9flDdM1SUCw== pablo.delgado@nb-pdelgado.local\n",
    :gid => 4001,
    :uid => 4001
  }],

  :groups => [{
    :name => 'www-data',
    :members => ['www-data', 'capistrano']
  }],

  :yumit => {
    :dir => '/www/yumit',
    :server_name => 'yumit20.yumit.com',
    :server_aliases => ['yumit20.yumit.com'],
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

  :motd => "Welcome to the Yumit DEV EC2 web server instance.\n\n" +
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
