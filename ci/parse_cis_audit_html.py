#!/usr/bin/env python3
import argparse
from bs4 import BeautifulSoup

__DESCRIPTION__ = """
Search for failed scan results to determine if an image can
promote from staging to production
"""
# This is a script to parse the output of
# the usg audit in html from cis-audit.html


def main():
    """This is the logic for finding out if there are any failed cves"""
    status = "passed"
    args = get_args()
    with open(args.inputfile, encoding="utf-8") as file_pointer:
        soup = BeautifulSoup(file_pointer, 'html.parser')
    divs = soup.findAll('div', {"class": "progress-bar"})
    for div in divs:
        progress_line = div.getText()
        if progress_line.find("failed") > 0:
            lines = progress_line.split()
            if len(lines) > 1 and int(lines[0]) > 0:
                status = "failed"
    print(status)


def get_args():
    """Parse the arguments looking for just one, inputfile"""
    parser = argparse.ArgumentParser(description=__DESCRIPTION__)
    parser.add_argument('--inputfile', help="the cis-audit html file>")
    return parser.parse_args()


if __name__ == '__main__':
    main()
