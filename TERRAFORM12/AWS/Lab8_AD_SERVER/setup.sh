#!/bin/bash

sh-keygen -q -t rsa -N '' -f ~/.ssh/id_rsa 2>/dev/null <<< y >/dev/null
cat .ssh/id_rsa > /root/.ssh/id_rsa
cat .ssh/id_rsa.pub > /root/.ssh/id_rsa.pub

echo "alias grep='grep --color=always'" >> /root/.bashrc
echo "alias ok='terraform apply  tfplan'" >> /root/.bashrc
echo "alias ck='terraform plan -out=tfplan'" >> /root/.bashrc
echo "alias ko='terraform destroy -auto-approve'" >> /root/.bashrc
echo "alias in='terraform init'" >> /root/.bashrc

cd /tmp
yum install unzip git telnet -y
curl "https://s3.amazonaws.com/aws-cli/awscli-bundle.zip" -o "awscli-bundle.zip"
unzip awscli-bundle.zip
./awscli-bundle/install -i /usr/local/aws -b /usr/local/bin/aws

mv /usr/local/bin/terraform /usr/local/bin/terraform.0.11.13
wget https://releases.hashicorp.com/terraform/0.12.21/terraform_0.12.21_linux_amd64.zip
unzip terraform_0.12.21_linux_amd64.zip
cp terraform /usr/bin/
cp terraform /usr/local/bin/

echo -e "\n\n===========>> AWS CLI version : <<================"
aws --version

echo -e "\n\n===========>> TERRAFORM version : <<================"
terraform -v
