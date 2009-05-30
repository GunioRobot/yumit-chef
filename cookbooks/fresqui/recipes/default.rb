include_recipe "apache2"
include_recipe "passenger"
include_recipe "rails"
include_recipe "runit"
include_recipe "memcached"

gem_package 'daemons' do
  action :install
  version '1.0.10'
end

gem_package 'hpricot' do
  action :install
  version '0.6.164'
end

gem_package 'sqlite3-ruby' do
  action :install
  version '1.2.4'
end

['', '/shared', '/releases'].each do |path|
  directory "#{node[:fresqui][:dir]}#{path}" do
    action :create
    recursive true
    owner node[:fresqui][:user]
    group "www-data"
    mode 02774
  end
end

memcached_instance "fresqui"

web_app "fresqui" do
  server_name node[:fresqui][:server_name]
  docroot "#{node[:fresqui][:dir]}/current/public"
  server_aliases [node[:hostname]] + (node[:fresqui][:server_aliases] || [])
  template "fresqui.conf.erb"
end
