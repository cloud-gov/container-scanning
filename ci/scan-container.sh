#!/bin/bash

set -ex 
grype ${IMAGE} -q -o json --file output.json

cat output.json | jq '.matches | .[]? |  .vulnerability.severity' >> severity.txt

echo "High:"

grep -o -i high severity.txt | wc -l

