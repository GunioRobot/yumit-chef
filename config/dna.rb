require 'rubygems'
require 'json'

dna = {
  :assigned_hostname => 'fresqui01',
  :assigned_domain => 'fresqui.com',
  :ipaddress => '79.125.12.4',

  :ebs_volumes => {
    'ebs1' => {
      :mount_point => '/db',
      :type => 'ext3',
      :device => '/dev/sdf'
    }
  },
  :mysql => {
    :ec2_path => '/db/mysql',
    
    :server_root_password => 'belen3'
  }, 

  :recipes => [
    'ec2',
    'ec2::filesystems',
    'mysql::server'
  ]
}

open(File.dirname(__FILE__) + "/dna.json", "w").write(dna.to_json)
