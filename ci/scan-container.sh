#!/bin/bash

set -ex 
grype dir:${IMAGE} -q -o json --file output.json

cat output.json

