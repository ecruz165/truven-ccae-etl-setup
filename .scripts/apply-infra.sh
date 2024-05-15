#!/bin/bash

ENVIRONMENT=$1

if [ ! -d ".infra" ]; then
    echo "Error: .infra directory does not exist."
    exit 1
fi

cd .infra

if [ "$ENVIRONMENT" = "local" ]; then 
    echo "Targeting localstack environment"
    tflocal init && tflocal workspace new local
    tflocal apply -auto-approve || { echo "Terraform apply failed"; exit 1; }
else
    echo "Targeting AWS environment"
    terraform init && terraform workspace new $ENVIRONMENT
    terraform apply -auto-approve || { echo "Terraform apply failed"; exit 1; }
fi
