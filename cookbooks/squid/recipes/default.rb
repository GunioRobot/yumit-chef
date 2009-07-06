package "squid" do
  action :install
end

package "squidclient" do
  action :install
end

service "squid" do
  supports :restart => true, :reload => true
end

directory node[:squid][:cache_dir] do
  owner 'proxy'
  group 'proxy'
  action :create
  recursive true
end

template "/etc/squid/squid.conf" do
  source "squid.conf.erb"
  notifies :restart, resources(:service => "squid")
end

service "squid" do
  action [ :enable, :start ]
end