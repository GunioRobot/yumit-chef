sources [
  'deb http://eu.ec2.archive.ubuntu.com/ubuntu/ hardy main universe',
  'deb-src http://eu.ec2.archive.ubuntu.com/ubuntu/ hardy main universe',
  'deb http://eu.ec2.archive.ubuntu.com/ubuntu/ hardy-updates main universe',
  'deb-src http://eu.ec2.archive.ubuntu.com/ubuntu/ hardy-updates main universe',
  'deb http://security.ubuntu.com/ubuntu hardy-security main restricted',
  'deb-src http://security.ubuntu.com/ubuntu hardy-security main restricted',
  'deb http://eu.ec2.archive.ubuntu.com/ubuntu/ hardy multiverse',
  'deb-src http://eu.ec2.archive.ubuntu.com/ubuntu/ hardy multiverse',
  'deb http://eu.ec2.archive.ubuntu.com/ubuntu/ hardy-updates multiverse',
  'deb-src http://eu.ec2.archive.ubuntu.com/ubuntu/ hardy-updates multiverse'
] unless attribute?("sources")
