#!/bin/sh

SERVICE_DEF=$(ctx download-resource "config/ui.service")

sudo systemctl stop ui.service

sudo systemctl disable ui.service

cd /opt

sudo yum -y install wget unzip

sudo yum -y install epel-release

# Install the http-parser package due to temporary ABSENCE in centos
# https://bugzilla.redhat.com/show_bug.cgi?id=1481008

sudo rpm -i http://springdale.math.ias.edu/data/puias/unsupported/7/x86_64/http-parser-2.7.1-3.sdl7.x86_64.rpm

sudo yum -y install nodejs

sudo sed -i /var/lib/pgsql/data/pg_hba.conf -e "/127.0.0.1/s/ident/md5/"

sudo systemctl restart postgresql

sudo -u postgres psql -c "create database stage"

sudo wget ${scp_ui_zip}

sudo tar -xzf *.tar.gz

sudo echo "{  \"ip\": \"${manager_ip}\" }" > dist/conf/manager.json

sudo cp  $SERVICE_DEF /usr/lib/systemd/system/ui.service

sudo sudo rm -rf /etc/systemd/system/ui.service

sudo systemctl daemon-reload


sudo systemctl enable ui.service
sudo systemctl start ui.service
