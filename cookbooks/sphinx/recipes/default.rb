#
# Cookbook Name:: sphinx
# Recipe:: default
#
bash "install_sphinx" do
  user "root"
  cwd "/tmp"
  code <<-EOH
  wget http://www.sphinxsearch.com/downloads/sphinx-0.9.8.1.tar.gz && \
  tar -zxvf sphinx-0.9.8.1.tar.gz && \
  cd sphinx-0.9.8.1 && \
  ./configure --prefix=#{node[:sphinx][:prefix]} --with-mysql && \
  make && \
  make install
  EOH
  not_if { File.exist?('/usr/local/bin/searchd') }
end
