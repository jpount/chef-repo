#!/bin/bash

usage ()
{
  echo "Usage: ./ami_factory.sh <relative location to packer json file> [instance_size]"
  exit
}

packerfile=$1
instance_size=$2

# extra validation
if [ "$packerfile" = "" ]
then
    usage
fi
if [ "$instance_size" = "" ]
then
    instance_size="t2.micro"
fi

echo "Using.... Packerfile=$packerfile,Size=$instance_size"

rm -rf ./berks-cookbooks

berks vendor

packer build \
  -var "account_id=$AWS_ACCOUNT_ID" \
  -var "aws_access_key_id=$AWS_ACCESS_KEY_ID" \
  -var "aws_secret_key=$AWS_SECRET_ACCESS_KEY" \
  -var "x509_cert_path=$AWS_X509_CERT_PATH" \
  -var "x509_key_path=$AWS_X509_KEY_PATH" \
  -var "s3_bucket=bt-chef-packer-bucket" \
  $1

# Note: to restrict builds to only a specific ami type
# use the following flags in the packer build command
# -only=amazon-ebs
# -only=amazon-instance

rm -rf ./berks-cookbooks

