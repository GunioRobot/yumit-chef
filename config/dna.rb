require 'rubygems'
require 'json'

dna = {
  :host => {
    :hostname => 'front',
    :domain => 'fresqui.com',
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
    :bind_address => '127.0.0.1',
    :tunable => {
      :key_buffer => '250M',
      :net_read_timeout => '30'
    },
  },

  :sphinx => {
    :prefix => '/usr/local'
  },

  :apache => {
    :contact => 'jorgedf@fresqui.com'
  },

  :passenger => {
    :version => '2.2.2'
  },

  :rails => {
    :version => '2.3.2'
  },

  :packages => [
    'imagemagick',
    'htop',
    'git-core'
  ],

  :users => [{
    :username => 'capistrano',
    :authorized_keys => "ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEAw5b4okzvmo9TKfqz6zAP4Y38xnBN4UIGfbOO8OrrD9YPOBQiEd8RAvPrZ/oxTSutxABqEtUDowBa36WlRkGX9OVUvwXj+yec5BaBGPk4mqp+7YZJSeKhOrrWKVr43q9uNDxuChJD1+MwME6HnE/RvONPpF8OKEEfkYqd1GmxwGIMhgNK47MsK1lwAG06+5oMv6HySUWxMgoG25BaxK2+0Y77WDUqgaIwnymgOZekBPdPnixP8C4cWqH2gD/HNikVVOEd2gvztsMGbDfAiIkc/ryqcT3SM9ES565qKPsY5ZpDQfXsdl6RMwtwATOg3vLi9OBW4CaaDgIOBwfGppH3Vw== mbc@mbcbook.local",
    :gid => 4001,
    :uid => 4001
  }],

  :groups => [{
    :name => 'www-data',
    :members => ['www-data', 'capistrano']
  }],

  :fresqui => {
    :dir => '/www/fresqui',
    :server_name => 'fresqui.com',
    :server_aliases => ['www.fresqui.com'],
    :user => 'capistrano'
  },

  :motd => "Welcome to the Fresqui EC2 web server instance.\n\n" +
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
    'sphinx',
    'users',
    'groups',
    'postfix',
    'fresqui'
  ]
}

open(File.dirname(__FILE__) + "/dna.json", "w").write(dna.to_json)
