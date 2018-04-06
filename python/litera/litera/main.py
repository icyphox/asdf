#!/usr/bin/env python3

# Litera: A simple literature management utility.

import markdown2
import jinja2
import os
import sys
import argparse
from helpers import template


def create_args(parser):
    parser.add_argument('init',
                        help='Create a Litera project in the current directory.')
    parser.add_argument('')
    if sys.argv[1:] == 0:
        parser.print_help()
        parser.exit()
    args = parser.parse_args()
    return args


def create_notebook(path):
    try:
        os.mkdir(os.path.join(path, 'build'))
        os.mkdir(os.path.join(path, 'templates'))
    except FileExistsError:
        print('Error: specified path exists.')


def main():
    parser = argparse.ArgumentParser(description='A basic literature management utility.')
    args = create_args(parser)
    if args.init:
        create_notebook(os.getcwd())


if __name__ == "__main__":
    main()
