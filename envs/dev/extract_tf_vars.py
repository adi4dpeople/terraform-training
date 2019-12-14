#!/usr/bin/env python

from __future__ import print_function, with_statement

import os
import re


def main(args):
    curdir = os.getcwd()
    var_match = re.compile(r'var\.[a-zA-Z-_0-9]+')
    matches = set()
    for root, dirs, files in os.walk(curdir):
        dirs[:] = [d for d in dirs if d not in args.exclude and d[0] != '.']
        for _file in files:
            if _file.endswith('.tf') and _file not in args.exclude:
                with open(os.path.join(root, _file)) as f:
                    for no, line in enumerate(f.readlines()):
                        for match in re.findall(var_match, line):
                            if not line.lstrip().startswith('#'):
                                if args.debug:
                                    print('Found {0} on line {1} in {2}'.format(match, no + 1, _file))
                                else:
                                    matches.add(match.replace('var.', ''))

    sort_matches = sorted(matches)
    if args.tfvars:
        for var in sort_matches:
            print('{0} = PLACEHOLDER'.format(var))
    else:
        for var in sort_matches:
            print('variable \"{0}\" {{}}'.format(var))


if __name__ == '__main__':
    import argparse
    parser = argparse.ArgumentParser()
    parser.add_argument('-d', '--debug', action='store_true')
    parser.add_argument('-e', '--exclude', action='append', default=[], help='Exclude files and directories. Can use multiple times for multiple files/dirs')
    parser.add_argument('-t', '--tfvars', action='store_true', default=False, help='Generate tfvars output instead')
    args = parser.parse_args()
    main(args)
