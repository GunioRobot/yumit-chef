# Just manages membership of group so far - no group creation

package 'members' do
  action :install
end

node[:groups].each do |g|
  group g[:name] do
    members g[:members]
    not_if { `members #{g[:name]}`.strip.split(' ').uniq == g[:members] }
  end
end
