#!/bin/bash

set -ex 
grype dir:${IMAGE} -q --file output.json

cat output.json

