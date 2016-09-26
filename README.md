# Introduction

This is a systemd service that uses socket activation to implement a limited,
purpose-specific EC2 metadata service.

The context is to be able to run the [Jitsi
Videobridge](https://github.com/jitsi/jitsi-videobridge) inside a container
that's not assigned a public IP. The EC2 service is running on the host and
it's being queried by the container thourgh standard routing without any
additional configuration.

# How it works

ec2-metadata.sh: The "web server" is written in bash. It's based on
[this](https://debian-administration.org/article/371/A_web_server_in_a_shell_script)
example. You should install this in /usr/local/share/systemd-ec2-metadata/ and
it should be executable.

ec2-metadata@.service: The main service file. You should install this in
/lib/systemd/system/. The service expects to find the bash script in
/usr/local/share/systemd-ec2-metadata/.

ec2-metadata.socket: This is the systemd socket activation file. It needs to
be installed in /lib/systemd/system/.

In order to use it you need to add 169.254.169.254 as a loopback interface
alias on the LXD host. If you're on Ubuntu or Debian, you can modify the
/etc/network/interfaces file like this:

    auto lo:1
    iface lo:1 inet static
      address 169.254.169.254
      netmask 255.255.255.255
