include_recipe 'logrotate'

gem_package 'right_aws' do
  action :install
end

template "/usr/local/bin/snapshot.rb" do
  source "snapshot.rb.erb"
  owner 'root'
  mode 0700
  variables :public_key  => node[:ec2_settings][:public_key],
            :private_key => node[:ec2_settings][:private_key],
            :zone        => node[:ec2_settings][:zone]
end

if node[:snapshots]
  node[:snapshots].each do |device, settings|
    cron "backup /dev/#{device}" do
      user 'root'
      minute  settings[:minute]  if settings[:minute]
      hour    settings[:hour]    if settings[:hour]
      day     settings[:day]     if settings[:day]
      month   settings[:month]   if settings[:month]
      weekday settings[:weekday] if settings[:weekday]
      command "/usr/local/bin/snapshot.rb /dev/#{device} >> /var/log/snapshots.log 2>&1"
    end
  end
end

logrotate "snapshots.log" do
  files '/var/log/snapshots.log'
  enable true
  frequency 'weekly'
end
