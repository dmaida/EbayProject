#!/bin/bash

python fileParser.py ebay_data/items-*.xml

#python fileParser.py /usr/class/cs351/project/ebay_data/items-*.xml

sort user.dat | uniq > user.out
mv -f user.out user.dat

sqlite3 ebayD.db < create.sql
sqlite3 ebayD.db < load.txt
