#!/usr/bin/env python3
# -*- coding:utf-8 -*-
#
#   Author  :   renyuneyun
#   E-mail  :   renyuneyun@gmail.com
#   Date    :   24/08/29 11:40:37
#   License :   Apache 2.0 (See LICENSE)
#

'''
A simple utility to merge JSON files of the same structure to a single one.
'''

from collections import ChainMap
from argparse import ArgumentParser
from functools import reduce
import json


def recursive_merge(dict1, dict2, depth, replace_on):
    should_replace = not (replace_on and depth == replace_on)
    for key, value in dict2.items():
        if key in dict1 and isinstance(dict1[key], dict) and isinstance(value, dict) and should_replace:
            # Recursively merge nested dictionaries
            recursive_merge(dict1[key], value, depth+1, replace_on)
        elif key in dict1 and isinstance(dict1[key], list) and isinstance(value, list) and should_replace:
            dict1[key].extend(value)
        else:
            # Merge non-dictionary values
            dict1[key] = value
    return dict1


def merge_json_objs(json_obj_list, replace_on):
    # result = dict(ChainMap(*json_obj_list))
    result = reduce(lambda a, b: recursive_merge(a, b, depth=0, replace_on=replace_on), json_obj_list, {})
    return result


def merge(json_filenames, replace_on):
    json_obj_list = []
    for filename in json_filenames:
        with open(filename) as fd:
            json_obj = json.load(fd)
            json_obj_list.append(json_obj)
    merged_json_obj = merge_json_objs(json_obj_list, replace_on=replace_on)
    print(json.dumps(merged_json_obj))


def main():
    parser = ArgumentParser(description='''
A simple utility to merge JSON files of the same structure to a single one.

When duplicated keys are found, the default beahaviour is:
- Keep and merge all fields of dict and list
- For other types, replace with value in later JSON
''')
    parser.add_argument('json_file', nargs='+', help='Names of JSON files')
    parser.add_argument('--replace-on', type=int, help='Override the default behaviour of dict and list (at depth `REPLACE_ON`), and replace with value from later JSON.')
    args = parser.parse_args()
    merge(args.json_file, args.replace_on)


if __name__ == "__main__":
    main()
