for ebs_volume in (node["ebs_volumes"] || [])
  if (`grep /dev/#{ebs_volume[:device]} /etc/fstab` == "")
    while not File.exists?("/dev/#{ebs_volume[:device]}")
      Chef::Log.info("EBS volume device /dev/#{ebs_volume[:device]} not ready...")
      sleep 5
    end

    execute "format volume" do
      command "yes | mkfs -t ext3 /dev/#{ebs_volume[:device]}"
      not_if "file -s /dev/#{ebs_volume[:device]} | grep ext3"
    end

    directory ebs_volume[:path] do
      owner 'root'
      group 'root'
      mode 0755
    end

    mount ebs_volume[:path] do
      device "/dev/#{ebs_volume[:device]}"
      fstype "ext3"
    end
  end
end
