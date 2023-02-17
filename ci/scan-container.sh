#!/bin/bash
grype ${IMAGE} -c grype-scan-ignore-config/grype.yaml -q -o json --file cves/output.json
grype ${IMAGE} -c grype-scan-ignore-config/grype.yaml -q -o table --file table.txt

cat cves/output.json | jq '.matches | .[]? |  .vulnerability.severity' >> severity.txt

critical=$(grep -o -i critical severity.txt | wc -l)
high=$(grep -o -i high severity.txt | wc -l)
medium=$(grep -o -i medium severity.txt | wc -l)
low=$(grep -o -i low severity.txt | wc -l)
negligible=$(grep -o -i negligible severity.txt | wc -l)

echo "Critical: $critical\n"
echo "High: $high\n"
echo "Medium: $medium\n"
echo "Low: $low\n"
echo "Negligible: $negligible\n"

cat table.txt
