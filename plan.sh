#!/bin/bash
terraform plan -var-file=./env/dev.tfvars -var-file=./env/secrets.tfvars