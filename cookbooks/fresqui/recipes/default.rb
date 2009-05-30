include_recipe "apache2"
include_recipe "passenger"
include_recipe "rails"

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

web_app "fresqui" do
  server_name "fresqui.com"
  docroot "/www/fresqui/current/public"
  server_aliases [node[:hostname], "www.fresqui.com"]
  template "fresqui.conf.erb"
end
