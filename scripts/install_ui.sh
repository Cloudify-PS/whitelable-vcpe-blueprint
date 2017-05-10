#!/bin/sh
cd /opt

sudo yum -y install wget unzip

sudo yum -y install epel-release

sudo yum -y install nodejs

sudo sed -i /var/lib/pgsql/data/pg_hba.conf -e "/127.0.0.1/s/ident/md5/"

sudo systemctl restart postgresql

sudo -u postgres psql -c "create database stage"

sudo wget ${scp_ui_zip}

sudo tar -xzf *.tar.gz

sudo echo "{  \"ip\": \"${manager_ip}\" }" > dist/conf/manager.json

cd dist/backend

sudo sh -c 'nohup node server.js 2>&1 > /tmp/ui_log.txt &' 

#sudo nohup node server.js &
