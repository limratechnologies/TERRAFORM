#!/bin/bash

sed  -i "s/99/999/g" /boot/idle.sh
chattr -i /etc/ssh/sshd_config
chmod 644 /etc/ssh/sshd_config

yum -y update
yum install git wget mlocate telnet -y
echo "10.123.2.101 idm-server.linuxsysadmins.local idm-server" >> /etc/hosts

APP_IP=`ip -4 a show dev eth0 | grep inet | sed 's| *inet ||;s|/.*||'`


case $APP_IP in

        10.123.2.101)
                      echo "Setup IDM node"
                      yum install ipa-server ipa-server-dns bind bind-dyndb-ldap ipa-server-trust-ad -y
                      ipa-server-install  --setup-dns --no-forwarders --auto-reverse -p "Password01" -a "Password01" -n linuxsysadmins.local -r LINUXSYSADMINS.LOCAL --netbios-name=LINUXSYSADMINS --hostname=idm-server.linuxsysadmins.local --setup-adtrust --setup-kra --idstart=5000 --idmax=2000000 --auto-reverse --enable-compat --mkhomedir --no-host-dns --unattended
                      chattr +i /etc/resolv.conf
                      sed -i -e 's/dnssec-validation yes/dnssec-validation no/' /etc/named.conf
                      reboot
                      ;;
        10.123.2.102)
                     echo "Setup REPLICA node"
                     echo "$APP_IP ${HOSTNAME}.linuxsysadmins.local ${HOSTNAME}" >> /etc/hosts 
                     yum install ipa-server ipa-server-dns bind bind-dyndb-ldap ipa-server-trust-ad -y
                     ;;
        *)
                     echo "Setup Client node"
                     echo "$APP_IP ${HOSTNAME}.linuxsysadmins.local ${HOSTNAME}" >> /etc/hosts
                     yum -y install ipa-client ipa-admintools
                     cat <<EOF >/etc/resolv.conf
search linuxsysadmins.local
nameserver 10.123.2.101
EOF
                     chattr +i /etc/resolv.conf
                     ;;
esac
