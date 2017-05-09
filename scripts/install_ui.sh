#!/bin/sh
cd /opt

sudo yum -y install wget unzip

sudo yum -y install epel-release

sudo yum -y install nodejs

sudo -u postgres psql -c "create database stage"

sudo wget ${scp_ui_zip}

sudo tar -xzf *.tar.gz

sudo echo "{  \"ip\": \"172.16.0.3\" }" > dist/conf/manager.json

cd dist/backend

sudo nohup node server.js &
