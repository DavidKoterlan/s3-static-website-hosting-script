#!/bin/sh
cd ./infrastructure || exit
terraform destroy -auto-approve 