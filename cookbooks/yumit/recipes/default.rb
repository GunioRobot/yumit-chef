include_recipe "apache2"
include_recipe "apache2::mod_expires"
include_recipe "apache2::mod_deflate"
include_recipe "passenger"
include_recipe "rails"
include_recipe "runit"
# include_recipe "memcached"

gem_package 'daemons' do
  action :install
  version '1.0.10'
end

['', '/shared', '/releases', '/shared/system', '/shared/system/config', '/shared/log'].each do |path|
  directory "#{node[:yumit][:dir]}#{path}" do
    action :create
    recursive true
    owner node[:yumit][:user]
    group "www-data"
    mode 02775
  end
end

link "#{node[:yumit][:dir]}/shared/add_expires_header" do
 to "#{node[:yumit][:dir]}/current/public"
end

%w(database mailer config facebooker flickr).each do |template_file|
  template "#{node[:yumit][:dir]}/shared/system/config/#{template_file}.yml" do
    owner node[:yumit][:user]
    source "#{template_file}.yml.erb"
  end
end

template "#{node[:yumit][:dir]}/shared/kill_growing_processes.rb" do
  source "kill_growing_processes.rb.erb"
end

cron "kill_growing_processes" do
  minute "*/1"
  command "ruby #{node[:yumit][:dir]}/shared/kill_growing_processes.rb 100 >> #{node[:yumit][:dir]}/shared/log/process_killer.log 2>&1"
end


logrotate "production.log" do
  files "#{node[:yumit][:dir]}/shared/log/process_killer.log"
  enable true
  frequency 'daily'
end

logrotate "production.log" do
  files "#{node[:yumit][:dir]}/shared/log/production.log"
  enable true
  frequency 'daily'
end

logrotate "promote.log" do
  files "#{node[:yumit][:dir]}/shared/log/promote.log"
  enable true
  frequency 'daily'
end


['convert', 'mogrify', 'identify'].each do |cmd|
  link "/usr/local/bin/#{cmd}" do
    to "/usr/bin/#{cmd}"
  end
end
# memcached_instance "yumit"

web_app "yumit" do
  server_name node[:yumit][:server_name]
  docroot "#{node[:yumit][:dir]}/current/public"
  add_expires_header_path "#{node[:yumit][:dir]}/shared/add_expires_header"
  server_aliases [node[:hostname]] + (node[:yumit][:server_aliases] || [])
  template "yumit.conf.erb"
end
