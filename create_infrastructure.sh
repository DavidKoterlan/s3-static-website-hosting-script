#!/bin/sh
cd ./infrastructure || exit
terraform init
terraform apply -auto-approve 