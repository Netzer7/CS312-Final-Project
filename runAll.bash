#!/bin/bash

cd terraform
terraform init
terraform plan -out CreateServer
terraform apply CreateServer

cd ../ansible
bash runAnsible.sh  

cd ../terraform
sleep 30
nmap -sV -Pn -p T:25565 $(terraform output -raw minecraft_server_eip)