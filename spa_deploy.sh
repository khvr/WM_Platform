#!/bin/bash

if [ "$#" -ne 4 ]; then
    echo "Invalid number of parameters"
    echo Usage: bash spa_deploy.sh \<AWS_REGION\> \<AWS_PROFILE\> \<WORKSPACE\> \<DOMAIN_NAME\> 
    exit 1
fi

AWS_REGION=$1
AWS_PROFILE=$2
WORKSPACE=$3
DOMAIN_NAME=$4

export AWS_REGION=$AWS_REGION
export AWS_PROFILE=$AWS_PROFILE
export TF_WORKSPACE=$WORKSPACE
export TF_VAR_domain_name=$DOMAIN_NAME

echo Environment Variables:
echo $AWS_REGION
echo $AWS_PROFILE
echo $TF_WORKSPACE
echo $TF_VAR_domain_name

cd terraform/applications/resources

terraform init
if [ $? -ne "0" ]
then
  echo "Init failed....."
  exit 1
else
  echo "Init suceeded"
fi
terraform workspace select $TF_WORKSPACE || terraform workspace new $TF_WORKSPACE
terraform plan -var-file=../env/prod/us-east-1/terraform.tfvars
if [ $? -ne "0" ]
then
  echo "Plan failed....."
  exit 1
else
  echo "Plan suceeded"
fi
terraform apply -var-file=../env/prod/us-east-1/terraform.tfvars
if [ $? -ne "0" ]
then
  echo "Apply failed....."
  exit 1
else
  echo "Apply suceeded"
fi
echo Enter the path to SPA build files:
read SPA_BUILD_PATH

aws s3 sync $SPA_BUILD_PATH s3://$DOMAIN_NAME
if [ $? -ne "0" ]
then
  echo "Copy build failed....."
  exit 1
else
  echo "Copy build suceeded"
fi