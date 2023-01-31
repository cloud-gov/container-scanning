#!/bin/bash

#set up dir and file

mkdir audit
touch audit/cis-audit.html

#run cis audit

cis-audit level1_server

cp /usr/share/ubuntu-scap-security-guides/cis-18.04-report.html audit/cis-audit.html
