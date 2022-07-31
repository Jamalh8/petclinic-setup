# petclinic-setup
set-up VM via terraform and ansible to install docker
 
Modified from Leon Robinson

## Step 1 - Deploy AWS instances

> cd terraform-vm
> terraform init
> terraform plan 
> terraform apply

## Step 2 - Install docker to both VM's

cd /tmp/petclinic-set-up/ansible-playbook
ansible-playbook docker-install.yaml
