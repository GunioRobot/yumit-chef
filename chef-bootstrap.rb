#!/usr/bin/env ruby

def cmd(cmd)
  puts cmd; system(cmd)
end

puts "--------------"
puts "Chef Chef Chef"
puts

cmd "sudo apt-get -y update"
cmd "sudo apt-get -q -y install ruby ruby1.8-dev libopenssl-ruby1.8 rdoc ri irb build-essential wget"

cmd "curl -L 'http://rubyforge.org/frs/download.php/45905/rubygems-1.3.1.tgz' | tar xvzf -"
cmd "cd rubygems* && sudo ruby setup.rb --no-ri --no-rdoc"
cmd "sudo ln -sfv /usr/bin/gem1.8 /usr/bin/gem"
cmd "sudo gem install rdoc chef ohai --no-ri --no-rdoc --source http://gems.opscode.com --source http://gems.rubyforge.org"

puts
puts "It seems to have worked!"
puts "------------------------"
