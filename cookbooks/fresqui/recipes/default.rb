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

gem_package 'hpricot' do
  action :install
#  version '0.6.164'
  version "0.8.1"
  source "http://code.whytheluckystiff.net"
end

gem_package 'sqlite3-ruby' do
  action :install
  version '1.2.4'
end

['', '/shared', '/releases', '/shared/system', '/shared/system/config', '/shared/log'].each do |path|
  directory "#{node[:fresqui][:dir]}#{path}" do
    action :create
    recursive true
    owner node[:fresqui][:user]
    group "www-data"
    mode 02775
  end
end

link "#{node[:fresqui][:dir]}/shared/add_expires_header" do
 to "#{node[:fresqui][:dir]}/current/public"
end

template "#{node[:fresqui][:dir]}/shared/system/config/database.yml" do
  owner node[:fresqui][:user]
  source "database.yml.erb"
end

template "#{node[:fresqui][:dir]}/shared/system/config/mailer.yml" do
  owner node[:fresqui][:user]
  source "mailer.yml.erb"
end

template "#{node[:fresqui][:dir]}/shared/kill_growing_processes.rb" do
  source "kill_growing_processes.rb.erb"
end

cron "kill_growing_processes" do
  minute "*/1"
  command "ruby #{node[:fresqui][:dir]}/shared/kill_growing_processes.rb 100 >> #{node[:fresqui][:dir]}/shared/log/process_killer.log 2>&1"
end


logrotate "production.log" do
  files "#{node[:fresqui][:dir]}/shared/log/process_killer.log"
  enable true
  frequency 'daily'
end

logrotate "production.log" do
  files "#{node[:fresqui][:dir]}/shared/log/production.log"
  enable true
  frequency 'daily'
end

logrotate "promote.log" do
  files "#{node[:fresqui][:dir]}/shared/log/promote.log"
  enable true
  frequency 'daily'
end


['convert', 'mogrify', 'identify'].each do |cmd|
  link "/usr/local/bin/#{cmd}" do
    to "/usr/bin/#{cmd}" 
  end
end
# memcached_instance "fresqui"

web_app "fresqui" do
  server_name node[:fresqui][:server_name]
  docroot "#{node[:fresqui][:dir]}/current/public"
  add_expires_header_path "#{node[:fresqui][:dir]}/shared/add_expires_header"  
  server_aliases [node[:hostname]] + (node[:fresqui][:server_aliases] || [])
  template "fresqui.conf.erb"
end

web_app "beta.fresqui" do
  server_name "beta.fresqui.com"
  redirect_to "http://#{node[:fresqui][:server_name]}"
  template "beta.fresqui.conf.erb"
end
