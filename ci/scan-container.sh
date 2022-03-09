#!/bin/bash

set -ex 
grype ${IMAGE} -q --file output.json

cat output.json

