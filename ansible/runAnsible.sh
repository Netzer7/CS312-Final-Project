#!/bin/bash

# Fetch the Minecraft server's Elastic IP address
cd ../terraform
ELASTIC_IP=$(terraform output -raw minecraft_server_eip)
cd ../ansible
# Create the inventory file
echo "[minecraft]" > inventory
echo "$ELASTIC_IP ansible_user=ec2-user ansible_ssh_private_key_file=~/.ssh/Desktop.pem ansible_python_interpreter=/usr/bin/python3" >> inventory

ansible-playbook -i inventory playbook.yml        