#!/bin/bash

# Terraform state file location
TERRAFORM_STATE_FILE=terraform.tfstate

# Count the resources of mode "managed", excluding specified types
RESOURCE_COUNT=$(jq '[.resources[] | select(.mode == "managed") | select(.type == "terraform_data" or .type == "null_resource" | not) | .instances | flatten[]] | length' < "${TERRAFORM_STATE_FILE}")

# Output the resource count
echo "Total number of resource instances: ${RESOURCE_COUNT}"


# Output the names of the resources that were counted
jq -r '[.resources[] | select(.mode == "managed") | select(.type == "terraform_data" or .type == "null_resource" | not) | .type] | unique[]' < "${TERRAFORM_STATE_FILE}"