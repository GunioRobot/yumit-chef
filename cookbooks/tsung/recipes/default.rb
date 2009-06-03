package "gnuplot" do
  action :install
end

package "perl" do
  action :install
end

package "erlang" do
  action :install
end

package "erlang-src" do
  action :install
end

execute "install tsung" do
  cwd = '/tmp'
  command <<-EOH
  wget http://tsung.erlang-projects.org/dist/tsung-1.3.0.tar.gz && \
  tar -zxvf tsung-1.3.0.tar.gz && \
  cd tsung-1.3.0 && \
  ./configure && make && make install
  EOH
end
