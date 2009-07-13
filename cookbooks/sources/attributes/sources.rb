sources [
  'deb http://eu.ec2.archive.ubuntu.com/ubuntu/ intrepid main universe',
  'deb-src http://eu.ec2.archive.ubuntu.com/ubuntu/ intrepid main universe',
  'deb http://eu.ec2.archive.ubuntu.com/ubuntu/ intrepid-updates main universe',
  'deb-src http://eu.ec2.archive.ubuntu.com/ubuntu/ intrepid-updates main universe',
  'deb http://security.ubuntu.com/ubuntu intrepid-security main restricted',
  'deb-src http://security.ubuntu.com/ubuntu intrepid-security main restricted',
  'deb http://eu.ec2.archive.ubuntu.com/ubuntu/ intrepid multiverse',
  'deb-src http://eu.ec2.archive.ubuntu.com/ubuntu/ intrepid multiverse',
  'deb http://eu.ec2.archive.ubuntu.com/ubuntu/ intrepid-updates multiverse',
  'deb-src http://eu.ec2.archive.ubuntu.com/ubuntu/ intrepid-updates multiverse'
] unless attribute?("sources")
