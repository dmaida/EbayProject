#!/bin/bash

#use on personal machine on data
python fileParser.py ebay_data/items-*.xml

#python fileParser.py /usr/class/cs351/project/ebay_data/items-*.xml

sort user.dat | uniq > user.out
mv -f user.out user.dat

sqlite3 ebayD.db < create.sql
sqlite3 ebayD.db < load.txt

sqlite3 ebayD.db < trigger1_add.sql
sqlite3 ebayD.db < trigger2_add.sql
sqlite3 ebayD.db < trigger3_add.sql
sqlite3 ebayD.db < trigger4_add.sql

sqlite3 ebayD.db < query1.sql
sqlite3 ebayD.db < query2.sql
sqlite3 ebayD.db < query3.sql
sqlite3 ebayD.db < query4.sql
sqlite3 ebayD.db < query5.sql
sqlite3 ebayD.db < query6.sql
sqlite3 ebayD.db < query7.sql
