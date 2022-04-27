#!/bin/sh

set -e -x

aws ecr list-images --repository-name $IMAGE_REPOSITORY | jq -r '[.imageIds[].imageTag]' > image-list/tags.json

aws s3 cp image-list/tags.json "s3://${S3_TFSTATE_BUCKET}/${STACK_NAME}/tags.json"

cat image-list/tags.json