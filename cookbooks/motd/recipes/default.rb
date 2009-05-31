execute "updating motd" do
  command "update-motd --disable"
end

template "/etc/motd" do
  source "motd.erb"
end
