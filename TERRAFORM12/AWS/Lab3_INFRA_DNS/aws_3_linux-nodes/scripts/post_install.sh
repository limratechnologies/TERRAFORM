#!/bin/bash


yum -y update

yum install git wget mlocate telnet -y

wget https://packages.chef.io/files/stable/chef/13.12.14/el/7/chef-13.12.14-1.el7.x86_64.rpm

yum localinstall -y chef-13.12.14-1.el7.x86_64.rpm
mkdir /etc/chef ; mkdir /var/log/chef/
cp /tmp/client.rb /etc/chef/
cp /tmp/validation.pem /etc/chef/

#echo "nameserver 205.251.198.138" > /etc/resolv.conf

chef-client
