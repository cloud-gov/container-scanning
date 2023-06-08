#!/bin/bash

#get ecr image
PASSWD=$(aws ecr get-login-password --region ${AWS_DEFAULT_REGION})

CONFIG="\
{\n
    \"auths\": {\n
        \"${REGISTRY}\": {\n
            \"username\": \"AWS\",\n
            \"password\": \"${PASSWD}\"\n
        }\n
    }\n
}\n"

mkdir ~/.docker

printf "${CONFIG}" > ~/.docker/config.json

#scan
grype ${IMAGE} -c ci/grype.yaml -q -o json --file cves/output.json
grype ${IMAGE} -c ci/grype.yaml -q -o table --file table.txt

cat cves/output.json | jq '.matches | .[]? |  .vulnerability.severity' >> severity.txt

critical=$(grep -o -i critical severity.txt | wc -l)
high=$(grep -o -i high severity.txt | wc -l)
medium=$(grep -o -i medium severity.txt | wc -l)
low=$(grep -o -i low severity.txt | wc -l)
negligible=$(grep -o -i negligible severity.txt | wc -l)

echo "Critical: $critical"
echo "High: $high"
echo "Medium: $medium"
echo "Low: $low"
echo "Negligible: $negligible"

cat table.txt
