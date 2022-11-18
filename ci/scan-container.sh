#!/bin/bash

cp grype-scan-ignore-config ~/grype.yaml
grype ${IMAGE} -q -o json --file cves/output.json
grype ${IMAGE} -q -o table --file table.txt

cat cves/output.json | jq '.matches | .[]? |  .vulnerability.severity' >> severity.txt

critical=$(grep -o -i critical severity.txt | wc -l)
high=$(grep -o -i high severity.txt | wc -l)
medium=$(grep -o -i medium severity.txt | wc -l)
low=$(grep -o -i low severity.txt | wc -l)
negligible=$(grep -o -i negligible severity.txt | wc -l)

echo -n "Critical: $critical"
echo -n "High: $high"
echo -n "Medium: $medium"
echo -n "Low: $low"
echo -n "Negligible: $negligible"

cat table.txt
