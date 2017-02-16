#!/bin/bash

python skeleton_parser.py ./ebay_data/items-*.xml 

sort user.dat | uniq > user.out
mv -f user.out user.dat

sqlite3 ebayD.db < create.sql