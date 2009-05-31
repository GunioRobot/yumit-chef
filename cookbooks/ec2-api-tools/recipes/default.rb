include_recipe 'java'

package "unzip" do
  action :install
end

execute "install ec2-api-tools" do
  cwd '/tmp'
  command <<-EOH
  wget http://s3.amazonaws.com/ec2-downloads/ec2-api-tools-1.3-36506.zip && \
  unzip ec2-api-tools-1.3-36506.zip && \
  mv ec2-api-tools-1.3-36506 #{node[:ec2_api_tools][:install_dir]}
  EOH
  not_if { File.exist?(node[:ec2_api_tools][:install_dir]) }
end
