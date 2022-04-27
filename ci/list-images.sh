#!/bin/sh

set -e -x

aws ecr list-images --repository-name $IMAGE_REPOSITORY | jq -r .imageIds[].imageTag > image-list/tags.txt

aws s3 cp image-list/tags.txt "s3://${S3_TFSTATE_BUCKET}/${STACK_NAME}/tags.txt"

cat image-list/tags.txt