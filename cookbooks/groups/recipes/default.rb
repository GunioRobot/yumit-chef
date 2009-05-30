# Just manages membership of group so far - no group creation

node[:groups].each do |g|
  group g[:name] do
    members g[:members]
  end
end
