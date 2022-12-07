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

TAG=$(cat image-source/tag)

#scan
cp grype-scan-ignore-config ~/grype.yaml
grype ${IMAGE}:${TAG} -c grype-scan-ignore-config/grype.yaml -q -o cyclonedx --file output/${FILE}.xml

