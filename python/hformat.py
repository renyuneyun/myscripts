#!/usr/bin/env python3
# -*- coding:utf-8 -*-
#
#   Author  :   renyuneyun
#   E-mail  :   renyuneyun@gmail.com
#   Date    :   14/06/03 10:41:21
#   Desc    :   轉換數字單位使之更適合人類閱讀（B KB MB GB...）
#

import sys
import math

def toNum(possibleNum, units = ['B', 'KB', 'MB', 'GB', 'TB', 'PB', 'EB', 'ZB', 'YB']):
    try:
        return float(possibleNum)
    except:
        if possibleNum[-1] in units:
            return float(possibleNum[:-1])
        raise

def convert(token, units = ['B', 'KB', 'MB', 'GB', 'TB', 'PB', 'EB', 'ZB', 'YB'], base = 1024):
    result = token
    try:
        token = toNum(token)
    except:
        return token
    if token == 0:
        return 0
    index = int(math.log(token, base))
    if index >= len(units):
        index = len(units) - 1
    if index > 0:
        result = ('%.2f') % (token / math.pow(base, index)) + units[index]
    return result

def main():
    units = ['B', 'KB', 'MB', 'GB', 'TB', 'PB', 'EB', 'ZB', 'YB']
    base = 1024
    line = sys.stdin.readline()
    while line:
        tokens = line.split()
        for token in tokens:
            print(convert(token, units, base), end=' ')
        print()
        line = sys.stdin.readline()

if __name__ == '__main__':
    main()
