require 'rubygems'
require 'json'

dna = {
  :ebs_volumes => [
    {:device => 'sdf', :path => '/db'}
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

  :packages => [
    'imagemagick'
  ],

  :recipes => [
    'ec2-ebs',
    'apparmor',
    'mysql::server',
    'packages'
  ]
}

open(File.dirname(__FILE__) + "/dna.json", "w").write(dna.to_json)
