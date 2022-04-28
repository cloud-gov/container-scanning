#!/bin/bash

#install docker
apt-get update
apt-get install \
    ca-certificates \
    curl \
    gnupg \
    lsb-release -y

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null

apt-get update
apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin -y

#get ecr image
aws ecr get-login-password --region ${AWS_DEFAULT_REGION} | docker login --username AWS --password-stdin ${REGISTRY}

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
