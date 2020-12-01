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
firewall-cmd --permanent --zone=public --add-service=nfs
firewall-cmd --permanent --zone=public --add-service=mountd
firewall-cmd --permanent --zone=public --add-service=rpc-bind
firewall-cmd --reload
exportfs -r