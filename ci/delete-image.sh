#!/bin/sh

set -e -x

aws ecr batch-delete-image \
     --repository-name $IMAGE_REPOSITORY \
     --image-ids imageTag=1.0.2