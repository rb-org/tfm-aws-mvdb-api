#!/bin/bash

terraform destroy -var-file=./env/dev.tfvars -var-file=./env/secrets.tfvars