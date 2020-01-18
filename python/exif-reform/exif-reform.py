#!/usr/bin/env python3
# -*- coding:utf-8 -*-
#
#   Author  :   renyuneyun
#   E-mail  :   renyuneyun@gmail.com
#   Date    :   20/01/15 22:48:51
#   License :   Apache 2.0 (See LICENSE)
#

'''

'''

import sys
import glob

from datetime import datetime

from tqdm import tqdm
#from exif import Image #Toooooo slow
#from PIL import Image #Slow too
import piexif
from piexif import ExifIFD

def main():
    assert len(sys.argv) == 2
    path = sys.argv[1]
    no_exif_files = []
    no_original_time = []
    no_digitized_time = []
    original_older = []
    digitized_older = []
    time_equal = []
    unexpected = []
    for filename in tqdm(glob.glob(f"{path}/*.jpg")):
        exif_dict = piexif.load(filename)
        if not exif_dict:
            no_exif_files.append(filename)
            continue
        ex = exif_dict['Exif']
        try:
            time_original = bytes.decode(ex[ExifIFD.DateTimeOriginal])
        except KeyError:
            no_original_time.append(filename)
            time_original = None
        try:
            time_digitized = bytes.decode(ex[ExifIFD.DateTimeDigitized])
        except KeyError:
            no_digitized_time.append(filename)
            time_digitized = None
        if time_original and time_digitized:
            try:
                datetime_original = datetime.strptime(time_original, '%Y:%m:%d %H:%M:%S')
                datetime_digitized = datetime.strptime(time_digitized, '%Y:%m:%d %H:%M:%S')
                if datetime_original == datetime_digitized:
                    time_equal.append(filename)
                elif datetime_digitized > datetime_original:
                    original_older.append(filename)
                else:
                    digitized_older.append(filename)
                    exif_dict['Exif'][ExifIFD.DateTimeDigitized] = ex[ExifIFD.DateTimeOriginal]
                    exif_bytes = piexif.dump(exif_dict)
                    piexif.insert(exif_bytes, filename)
            except:
                unexpected.append(filename)
    print("no_exif_files: {}".format(no_exif_files))
    print("unexpected: {}".format(unexpected))
    print("time_equal: {}".format(time_equal))
    print("original_older: {}".format(original_older))
    print("digitized_older: {}".format(digitized_older))

if __name__ == '__main__':
    main()
