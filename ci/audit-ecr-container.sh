#!/bin/bash

#set up dir and file

mkdir audit
touch audit/cis-audit.html

#run cis audit and put html results into cis-audit.html file

usg audit cis_level1_server --html-file audit/cis-audit.html
