sources [
  'deb http://us-east-1.ec2.archive.ubuntu.com/ubuntu/ lucid main universe',
  'deb-src http://us-east-1.ec2.archive.ubuntu.com/ubuntu/ lucid main universe',
  'deb http://us-east-1.ec2.archive.ubuntu.com/ubuntu/ lucid-updates main universe',
  'deb-src http://us-east-1.ec2.archive.ubuntu.com/ubuntu/ lucid-updates main universe',
  'deb http://security.ubuntu.com/ubuntu lucid-security main universe',
  'deb-src http://security.ubuntu.com/ubuntu lucid-security main universe',
  'deb http://us-east-1.ec2.archive.ubuntu.com/ubuntu/ lucid multiverse',
  'deb-src http://us-east-1.ec2.archive.ubuntu.com/ubuntu/ lucid multiverse',
  'deb http://us-east-1.ec2.archive.ubuntu.com/ubuntu/ lucid-updates multiverse',
  'deb-src http://us-east-1.ec2.archive.ubuntu.com/ubuntu/ lucid-updates multiverse'
] unless attribute?("sources")
