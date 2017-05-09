#!/bin/bash

cd /opt/

sudo yum -y install wget unzip

sudo yum -y install python-gunicorn

sudo wget ${scp_backend_zip}

sudo unzip *.zip

cd partner_backend

sudo ./install_backend.sh

# edit configuratuion

# sudo ./prepare_backend.sh


# MOCK_RMS=True
#
