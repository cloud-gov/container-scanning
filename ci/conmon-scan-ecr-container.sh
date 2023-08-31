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
grype ${IMAGE}:${TAG} -c scan-source/ci/grype.yaml -q -o template -t scan-source/templates/conmon_csv.tmpl --file output/${FILE}.csv
# The JAB requires XML formatted reports so they can be uploaded to
# their vulnerability management tool.
grype ${IMAGE}:${TAG} -c scan-source/ci/grype.yaml -q -o cyclonedx --file output/${FILE}.xml
