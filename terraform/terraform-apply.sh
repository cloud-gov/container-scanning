#!/bin/bash

set -eu

# Execute the terraform action, the cloudfoundry provider will use CF_API and CF_TOKEN to authenticate
./pipeline-tasks/terraform-apply.sh
