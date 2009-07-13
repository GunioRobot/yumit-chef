execute "Kill dhclient" do
  command "kill #{File.read("/var/run/dhclient.eth0.pid").chomp}"
  only_if "pgrep dhclient"
end

bootstrap_fqdn = "#{node[:host][:hostname]}.#{node[:host][:domain]}"

bash "Add hosts entry for current node" do
  code "echo '#{node[:host][:ipaddress]} #{bootstrap_fqdn}' >> /etc/hosts"
  not_if "grep '#{node[:host][:ipaddress]} #{bootstrap_fqdn}' /etc/hosts"
end

bash "Set domain name" do
  code "echo #{node[:host][:domain]} > /etc/domainname"
  not_if "grep #{node[:host][:domain]} /etc/domainname"
end

bash "Write hostname" do
  code "echo #{bootstrap_fqdn} > /etc/hostname"
  not_if "grep #{bootstrap_fqdn} /etc/hostname"
end

bash "Set mailname for postfix" do
  code "echo #{bootstrap_fqdn} > /etc/mailname"
  not_if "grep #{node[:host][:hostname]} /etc/mailname"
end

execute "Set hostname" do
  command "/etc/init.d/hostname.sh"
  # Fix problem with hostname.sh exiting with 1 in spite of success
  # returns 1 if node[:platform] == 'ubuntu'
  only_if { `hostname -f`.strip != bootstrap_fqdn }
end

