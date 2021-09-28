#!/bin/bash

tfvars_file=${1:-terraform.tfvars}

get_var(){
	key=$1
	cat $tfvars_file | grep "$key = " | cut -d ' ' -f 3 | sed 's/\"//g'
}

bucket="$(get_var 'project')-terraform-state"
key='terraform.tfstate'
region="$(get_var 'region')"
dynamodb_table="$(get_var 'project')-terraform-state-lock"

terraform init \
	-backend-config="bucket=$bucket" \
	-backend-config="key=$key" \
	-backend-config="region=$region" \
	-backend-config="dynamodb_table=$dynamodb_table"
