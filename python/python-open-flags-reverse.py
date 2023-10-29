#!/usr/bin/env python3
# -*- coding:utf-8 -*-
#
#   Author  :   renyuneyun
#   E-mail  :   renyuneyun@gmail.com
#   Date    :   23/10/28 11:49:31
#   License :   Apache 2.0 (See LICENSE)
#

'''
Reverse check the flags for open(): input the integer representation of the flags, output the flag names.
'''

import os
import sys


FLAGNAMES = (
        'os.O_RDONLY',
        'os.O_WRONLY',
        'os.O_RDWR',
        'os.O_APPEND',
        'os.O_CREAT',
        'os.O_EXCL',
        'os.O_TRUNC',

        'os.O_DSYNC',
        'os.O_RSYNC',
        'os.O_SYNC',
        'os.O_NDELAY',
        'os.O_NONBLOCK',
        'os.O_NOCTTY',
        'os.O_CLOEXEC',

        'os.O_BINARY',
        'os.O_NOINHERIT',
        'os.O_SHORT_LIVED',
        'os.O_TEMPORARY',
        'os.O_RANDOM',
        'os.O_SEQUENTIAL',
        'os.O_TEXT',

        'os.O_EVTONLY',
        'os.O_FSYNC',
        'os.O_SYMLINK',
        'os.O_NOFOLLOW_ANY',

        'os.O_ASYNC',
        'os.O_DIRECT',
        'os.O_DIRECTORY',
        'os.O_NOFOLLOW',
        'os.O_NOATIME',
        'os.O_PATH',
        'os.O_TMPFILE',
        'os.O_SHLOCK',
        'os.O_EXLOCK',
        )


def compare_and_match(iflags):
    for flag_name in FLAGNAMES:
        try:
            flag = eval(flag_name)
        except AttributeError:
            continue
        flag_name_clean = flag_name[3:]
        if flag & iflags:
            yield flag, flag_name_clean
        # For debugging / inputting all flags
        # yield flag, flag_name_clean


def main():
    iflags = int(sys.argv[1])
    matches = dict(compare_and_match(iflags))
    matches[iflags] = '#input#'
    for flag, flag_name in sorted(matches.items()):
        print(f"{flag:23b}\t{flag_name}")


main()
