template "/etc/apt/sources.list" do
  owner 'root'
  group 'root'
  mode 0644
  source "sources.list.erb"
  variables :sources => node[:sources]
end
