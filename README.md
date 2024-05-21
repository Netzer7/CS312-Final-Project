
# Minecraft Server Deployment with Terraform, Ansible, and GitHub Actions

## Background

### What will we do?
We will automate the deployment of a Minecraft server using Terraform, and Ansible. The Terraform configuration will provision an AWS EC2 instance, and the Ansible playbook will configure the instance to run a Minecraft server within a docker container. This server will be started upon the instance rebooting, and will use a static IP address to remain constant.

### How will we do it?
1. **Terraform**: Provision the necessary AWS infrastructure.
2. **Ansible**: Configure the EC2 instance to run a Dockerized Minecraft server.

## Requirements

### What will the user need to configure to run the pipeline?
- AWS account with permissions to create VPCs, subnets, security groups, EC2 instances, and Elastic IPs.
- GitHub repository containing the Terraform and Ansible configurations.

### What tools should be installed?
- Terraform
- Ansible
- AWS CLI

### Are there any credentials or CLI required?
- AWS Access Key ID and Secret Access Key.
- SSH key pair for accessing the EC2 instance.

### Should the user set environment variables or configure anything?
- Configure AWS CLI access by running `aws configure`, and have a ssh keypair configured through AWS and located on user machine.

## List of Commands to Run, with Explanations

1. **Clone the Repository**:
    ```
    git clone https://github.com/your-repo/minecraft-deployment.git
    cd minecraft-deployment
    ```

2. **Configure the following variables**:
    - **AWS_ACCESS_KEY_ID**: Your AWS access key ID.
    - **AWS_SECRET_ACCESS_KEY**: Your AWS secret access key.
    - **SSH_PRIVATE_KEY**: Your SSH private key. Update this line in the main.tf file `key_name = "Desktop"`

3. **Run Terraform provisioning to spin up EC2 Instance**
    ```
    cd terraform
    terraform apply CreateServer
     ```
4. **Execute ansible playbook to configure server**
    Use the provided bash script which pulls the public ip generated as output from the terraform application.
    ```
    cd ../ansible
    bash runAnsible.sh  
    ```
    Additionally, this two step has been automated and can be ran with `bash runAll.bash` at the top level directory instead.
## How to Connect to the Minecraft Server Once It's Running

1. **Retrieve the Public IP**:
    - The public IP of the Minecraft server is output by the Terraform configuration, and is shown several times through the set-up. Take note.

2. **Connect to the Minecraft Server**:
    - Open Minecraft on your computer.
    - Go to "Multiplayer".
    - Click on "Add Server".
    - Enter the public IP of the Minecraft server as the server address.
    - Click "Done" and then "Join Server".

Your Minecraft server should now be running and accessible! Enjoy your game!

---
