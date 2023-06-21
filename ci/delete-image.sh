#!/bin/sh

set -e -x

aws ecr batch-delete-image \
     --repository-name ${IMAGE_REPOSITORY} \
     --image-ids imageTag=${IMAGE_TAG} \
     --region ${AWS_DEFAULT_REGION}