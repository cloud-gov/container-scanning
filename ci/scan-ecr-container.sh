#!/bin/bash

#get ecr image
PASSWD=$(aws ecr get-login-password --region ${AWS_DEFAULT_REGION})

CONFIG="\
{\n
    \"auths\": {\n
        \"${REGISTRY}\": {\n
            \"auth\": \"${PASSWD}\"\n
        }\n
    }\n
}\n"

mkdir ~/.docker

printf "${CONFIG}" > ~/.docker/config.json

#scan
grype ${IMAGE} -q -o json --file output.json
grype ${IMAGE} -q -o table --file table.txt

cat output.json | jq '.matches | .[]? |  .vulnerability.severity' >> severity.txt


echo -n "Critical: " && grep -o -i critical severity.txt | wc -l
echo -n "High: " && grep -o -i high severity.txt | wc -l
echo -n "Medium: " && grep -o -i medium severity.txt | wc -l
echo -n "Low: " && grep -o -i low severity.txt | wc -l
echo -n "Negligible: " && grep -o -i negligible severity.txt | wc -l

cat table.txt
