#!/bin/bash

set -ex 
grype ${IMAGE} -q -o json --file output.json
grype ${IMAGE} -q -o table --file table.txt

cat output.json | jq '.matches | .[]? |  .vulnerability.severity' >> severity.txt


echo "Critical:" | grep -o -i critical severity.txt | wc -l
echo "High:" | grep -o -i high severity.txt | wc -l
echo "Medium:" | grep -o -i medium severity.txt | wc -l
echo "Low:" | grep -o -i low severity.txt | wc -l
echo "Negligible:" | grep -o -i negligible severity.txt | wc -l

cat table.txt
