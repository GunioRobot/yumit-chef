#
# Cookbook Name:: users
# Recipe:: default
#

node[:users].each do |user|
  group user[:username] do
    gid user[:gid]
  end

  home_dir = "/home/#{user[:username]}"
  
  user user[:username] do
    password user[:password].crypt(user[:username]) if user[:password]
    uid user[:uid]
    gid user[:gid]
    home home_dir
    shell user[:shell] || "/bin/bash"
    action :create
  end

  directory "#{home_dir}/.ssh" do
    owner user[:uid]
    group user[:gid]
    mode 0700
  end
  
  for custom_file in user[:custom_files] || []
    template (custom_file[:path] || "#{home_dir}/#{custom_file[:name]}") do
      owner user[:uid]
      group user[:gid]
      mode custom_file[:mode] || 0744
      variables :content => custom_file[:content]
      source "custom.erb"
    end
  end
  
  template "#{home_dir}/.ssh/authorized_keys" do
    owner user[:uid]
    group user[:gid]
    mode 0600
    source "authorized_keys.erb"
    
    variables :user => user
  end if user[:authorized_keys]
end
