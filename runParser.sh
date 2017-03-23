#!/bin/bash

#use on personal machine on data
python fileParser.py ebay_data/items-*.xml

#python fileParser.py /usr/class/cs351/project/ebay_data/items-*.xml

sort user.dat | uniq > user.out
mv -f user.out user.dat

sqlite3 ebayD.db < create.sql
sqlite3 ebayD.db < load.txt

sqlite3 ebayD.db < trigger8_add.sql
sqlite3 ebayD.db < trigger9_add.sql
sqlite3 ebayD.db < trigger11_add.sql
sqlite3 ebayD.db < trigger12_add.sql

sqlite3 ebayD.db < trigger16_add.sql

sqlite3 ebayD.db < queries/query1.sql
sqlite3 ebayD.db < queries/query2.sql
sqlite3 ebayD.db < queries/query3.sql
sqlite3 ebayD.db < queries/query4.sql
sqlite3 ebayD.db < queries/query5.sql
sqlite3 ebayD.db < queries/query6.sql
sqlite3 ebayD.db < queries/query7.sql
