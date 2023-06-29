#!/usr/bin/env bash

# set up dir and file
mkdir audit
touch audit/cis-audit.html
cp /Users/robertagottlieb/Downloads/cis-audit.html audit

echo "about to install bs4"
# Install the python library BeautifulSoup to parse html 
pip3 install beautifulsoup4

# Run cis audit and put html results into cis-audit.html file
# usg audit cis_level1_server --html-file audit/cis-audit.html
echo "pretending to run usg audit cis_level1_server --html-file audit/cis-audit.html"

# Parse the resulting cis-audit.html file looking for pass/fail via a python script
# Do we need: chmod +x parse_cis_audit_html 
if [ "$(./parse_cis_audit_html.py --inputfile audit/cis-audit.html)" == "failed" ]
then
  echo "failed in shell"
  exit 1 
fi

# Uninstall beautifulsoup4 to keep our image tidy
echo "about to uninstall bs4"
pip3 uninstall beautifulsoup4


