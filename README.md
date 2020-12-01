# hw04
Добавляю в скрипт для VM nfss - nfss_script.sh

Заколовок:
>#!/bin/bash 

Установка nfs-utils:
>yum install -y nfs-utils

Создание папки nfs:

>mkdir /usr/local/nfs

Создание папки uoload:
>mkdir /usr/local/nfs/upload

Измение прав:

>chmod 777 /usr/local/nfs/upload

Объявление расшариваемой папки:

>echo "/usr/local/nfs     *(rw,sync)" > /etc/exports

Включение UDP:
>sed -i 's/# udp=y/udp=y/g' /etc/nfs.conf

Включение NFS v3:
>sed -i 's/# # vers3=y/vers3=y/g' /etc/nfs.conf

Запуск и установка в автозагрузку nfs и firewall:
>systemctl enable nfs 
>systemctl start nfs
>systemctl enable firewalld
>systemctl start firewalld

Прописываю правила в firewall и перезагружаю службу:
>firewall-cmd --permanent --zone=public --add-service=nfs
>firewall-cmd --permanent --zone=public --add-service=mountd
>firewall-cmd --permanent --zone=public --add-service=rpc-bind
>firewall-cmd --reload

Актуализация изменений в nfs:
>exportfs -r


В скрипт nfsc_script.sh строку для автомонтирования расшаренной папки:

>#!/bin/bash

>192.168.50.10:/usr/local/nfs    /mnt   nfs    rsize=8192,wsize=8192,rw,sync > /etc/fstab
