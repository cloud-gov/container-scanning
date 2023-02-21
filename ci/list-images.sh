#!/bin/sh

set -e -x

aws ecr list-images --repository-name $IMAGE_REPOSITORY | jq -r '[.imageIds|=sort_by(.imageTag) | .imageIds[].imageTag]' > image-list/tags-$IMAGE_REPOSITORY.json

aws s3 cp image-list/tags-$IMAGE_REPOSITORY.json "s3://${S3_TFSTATE_BUCKET}/${STACK_NAME}/tags-${IMAGE_REPOSITORY}.json"

cat image-list/tags-$IMAGE_REPOSITORY.json