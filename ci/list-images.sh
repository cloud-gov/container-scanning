#!/bin/sh

set -e -x

aws ecr list-images --repository-name $IMAGE_REPOSITORY > list.txt

cat list.txt | .imageIds[].imageTag > image-list/tags.txt