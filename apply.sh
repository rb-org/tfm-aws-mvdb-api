#!/bin/bash

terraform apply -auto-approve -var-file=./env/dev.tfvars -var-file=./env/secrets.tfvars