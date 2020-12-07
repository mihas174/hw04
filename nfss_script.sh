#!/bin/bash
yum install -y nfs-utils
mkdir /usr/local/nfs
mkdir /usr/local/nfs/upload
chmod 777 /usr/local/nfs/upload
echo "/usr/local/nfs     *(rw,sync)" > /etc/exports
sed -i 's/# udp=y/udp=y/g' /etc/nfs.conf
sed -i 's/# # vers3=y/vers3=y/g' /etc/nfs.conf
systemctl enable nfs
systemctl start nfs
systemctl enable firewalld
systemctl start firewalld
firewall-cmd --zone=public --permanent --add-port=111/tcp
firewall-cmd --zone=public --permanent --add-port=111/udp
firewall-cmd --zone=public --permanent --add-port=2049/tcp
firewall-cmd --zone=public --permanent --add-port=2049/udp
firewall-cmd --reload
exportfs -r
