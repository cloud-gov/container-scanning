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

mkdir output

#scan
grype ${IMAGE}:${TAG} -q -o cyclonedx --file output/output.xml

