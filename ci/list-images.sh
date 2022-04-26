#!/bin/sh

set -e -x

aws ecr list-images --repository-name $IMAGE_REPOSITORY | jq -r .imageIds[].imageTag > image-list/tags.txt

cat image-list/tags.txt