template "/etc/apt/sources.list" do
  source "sources.list.erb"
  variables :sources => node[:sources]
end
