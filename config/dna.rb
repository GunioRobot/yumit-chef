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

  :recipes => [
    'ec2-ebs',
    'apparmor',
    'mysql::server',
    'packages',
    'memcached',
    'fresqui'
  ]
}

open(File.dirname(__FILE__) + "/dna.json", "w").write(dna.to_json)
