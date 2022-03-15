#!/bin/bash

set -ex 
grype ${IMAGE} -q -o cyclonedx --file output.json

cat output.json

