#!/usr/bin/env python
#
# Convert .itermcolors files to hex colors for html

import sys
import xml.etree.ElementTree as ET


def rgb_to_hex(rgb):
    return "#%02x%02x%02x" % rgb


# MAIN
def main():

    if len(sys.argv) < 2:
        print("usage: ./convert_itermcolors.py file.itermcolors")
        exit()

    tree = ET.parse(sys.argv[1])
    root = tree.getroot()

    keys = root.findall("./dict/key")
    dicts = root.findall("./dict/dict")

    for i in range(len(keys)):
        b = int(float(dicts[i][1].text) * 255.0)
        g = int(float(dicts[i][3].text) * 255.0)
        r = int(float(dicts[i][5].text) * 255.0)
        print(rgb_to_hex((r, g, b)) + " //" + keys[i].text)


if __name__ == "__main__":
    main()
