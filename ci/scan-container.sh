#!/bin/bash

set -ex 
grype ${IMAGE} -q -o table --file output.json

cat output.json

