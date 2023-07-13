#!/bin/bash

# set up dir and file
mkdir audit
touch audit/cis-audit.html

echo "installing bs4"
# Install the python library BeautifulSoup to parse html 
pip3 install beautifulsoup4

# Run cis audit and put html results into cis-audit.html file
echo "running audit"
usg audit cis_level1_server --html-file audit/cis-audit.html

# Parse the resulting cis-audit.html file looking for pass/fail via a python script
if [ "$(./scan-source/ci/parse_cis_audit_html.py --inputfile audit/cis-audit.html)" == "failed" ]
then
  echo "uninstalling bs4"
  pip3 uninstall -y beautifulsoup4
  echo "Container hardening audit for ${IMAGE} - Failed"
  exit 1 
fi

# Uninstall beautifulsoup4 to keep our image tidy
echo "uninstalling bs4"
pip3 uninstall -y beautifulsoup4

echo "Container hardening audit for ${IMAGE} - Passed"