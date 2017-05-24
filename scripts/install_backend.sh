#!/bin/bash

ctx logger "Installing OS software"

sudo yum -y install epel-release

sudo yum -y install wget unzip

sudo yum -y install python-gunicorn


cd /opt/

ctx logger "Downloading Backend"

sudo wget ${scp_backend_zip}

sudo unzip *.zip

rm -rf *.zip

ctx logger "installing Backend"

cd partner-backend-1.0

sudo ./install_backend.sh

# edit configuratuion

ctx logger "Preparing BackEnd"

sudo sed -i /home/cspbackend/postgresql.cfg -e "/MANAGER/s/185.98.148.216/${manager_ip}/"

sudo sed -i /home/cspbackend/postgresql.cfg -e "/MOCK_CLOUDIFY/s/True/False/"

sudo sed -i /home/cspbackend/postgresql.cfg -e "/MANAGER_PASSWORD/s/Day21NB5ILWy/${manager_password}/"

sudo ./prepare_backend.sh

ctx logger "Populating Example Customers"

cd /opt/partner-backend-1.0/load-tests

sudo python demo_test.py

# MOCK_RMS=True
#
