#!/bin/bash



sudo yum -y install epel-release

sudo yum -y install wget unzip

sudo yum -y install python-gunicorn


cd /opt/

sudo wget ${scp_backend_zip}

sudo unzip *.zip

rm -rf *.zip


cd partner-backend-1.0

sudo ./install_backend.sh

# edit configuratuion

sudo sed -i /home/cspbackend/postgresql.cfg -e "/MANAGER/s/185.98.148.216/172.16.0.3/"

sudo sed -i /home/cspbackend/postgresql.cfg -e "/MOCK_CLOUDIFY/s/True/False/"

sudo sed -i /home/cspbackend/postgresql.cfg -e "/MANAGER_PASSWORD/s/Day21NB5ILWy/nEQSwrbNPz1w/"

sudo ./prepare_backend.sh

sudo python /opt/partner-backend-1.0/load-tests/load_test.py

# MOCK_RMS=True
#
