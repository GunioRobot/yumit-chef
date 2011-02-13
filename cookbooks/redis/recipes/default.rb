#
# Cookbook Name:: redis
# Recipe:: default
#

template "/etc/redis.conf" do
  owner 'root'
  group 'root'
  mode 0644
  source 'redis.conf.erb'
  variables(:pidfile => '/var/run/redis.pid', :logfile => '/var/log/redis.log')
end

directory "/db/redis" do
    action :create
    recursive true
    owner "root"
    group "root"
    mode 02775
    not_if "test -d /db/redis"
end

bash "install_redis" do
  user "root"
  cwd "/tmp"
  code <<-EOBASH
    wget --no-check-certificate http://github.com/antirez/redis/tarball/v1.3.11 -O redis-v1.3.11.tar.gz
    tar xzf redis-v1.3.11.tar.gz
    cd antirez-redis-b2739d9
    make
    cd ..
    mv antirez-redis-b2739d9 /usr/local/redis-1.3.11
    rm /usr/local/redis
    ln -s /usr/local/redis-1.3.11 /usr/local/redis
  EOBASH
  not_if "test -d /usr/local/redis-1.3.11"
end

bash "start_redis" do
  user "root"
  cwd "/usr/local/redis"
  code <<-EOBASH
    ./redis-server /etc/redis.conf
  EOBASH
  not_if "netstat -lptn | grep :6379"
end

