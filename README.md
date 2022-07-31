# petclinic-setup
Terraform to set up VM's
Ansible to install docker to those VM's
 
Modified from Leon Robinson's repo (https://github.com/Crush-Steelpunch/Minikube-Aws-Env.git)

# Clone repo and follow steps below.

## Step 1 - Set your AWS key name.

- go to terraform-vm/terraform.tfvars file.
- change sshkeypair name to your own AWS keypair name.

## Step 2 - Deploy AWS instances.

- cd terraform-vm
- terraform init
- terraform plan 
- terraform apply

## Step 3 - Install docker to both VM's.

- cd /tmp/petclinic-setup/ansible/
- ansible-playbook docker-install.yaml

## Step 4 - If installing Jenkins then

- cd /tmp/petclinic-setup/jenkins
- sudo chmod +x install-jenkins.sh
- ./install-jenkins.sh
