#!/bin/bash

set -ex 
grype ${IMAGE} >> output.json

cat output.json

