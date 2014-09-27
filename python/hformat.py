#!/usr/bin/env python3
# -*- coding:utf-8 -*-
#
#   Author  :   renyuneyun
#   E-mail  :   renyuneyun@gmail.com
#   Date    :   14/06/03 10:41:21
#   Desc    :   轉換數字單位使之更適合人類閱讀
#

import sys

def is_num(possibleNum):
    try:
        float(possibleNum)
        return True
    except:
        return False

def convert(token, units = ['B', 'KB', 'MB', 'GB', 'TB', 'PB']):
    if not is_num(token):
        return token
    length = len(token)
    if length > 4:
        token = float(token)
        index = 0
        while token > 1024:
            index += 1
            token = token / 1024
        result = ('%.1f') % (token) + units[index]
        #result = ' ' * (length - len(result)) + result
    else:
        result = token
    return result

def main():
    units = ['B', 'KB', 'MB', 'GB', 'TB', 'PB', 'EB', 'ZB', 'TB']
    line = sys.stdin.readline()
    while line:
        tokens = line.split()
        for token in tokens:
            print(convert(token, units), end=' ')
        print()
        line = sys.stdin.readline()

if __name__ == '__main__':
    main()
