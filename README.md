# hw04

Домашнее задание состоит в том что бы организовать стенд, который автоматически поднимает 2 виртуалки, настраивает NFS сервер на nfss и монтирует и настраивает сетевую шару на nfsc, использовал версию 3 и подключено по протоколу UDP. (команда в помощь "nfsstat -m" ).

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


В скрипт nfsc_script.sh добавляю следующее для автомонтирования расшаренной папки:

>#!/bin/bash

>echo "192.168.50.10:/usr/local/nfs    /mnt   nfs    rsize=8192,wsize=8192,rw,sync" >> /etc/fstab
