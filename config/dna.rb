require 'rubygems'
require 'json'

dna = {
  :ebs_volumes => [
    {:device => 'sdf', :path => '/db'},
    {:device => 'sdg', :path => '/www'}
  ],

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

  :apache => {
    :contact => 'jorgedf@fresqui.com'
  },

  :rails => {
    :version => '2.3.2'
  },

  :packages => [
    'imagemagick',
    'htop'
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

  :recipes => [
    'ec2-ebs',
    'apparmor',
    'mysql::server',
    'packages',
    'users',
    'groups',
    'fresqui'
  ]
}

open(File.dirname(__FILE__) + "/dna.json", "w").write(dna.to_json)
