#!/bin/bash

python fileParser.py ./ebay_data/items-*.xml 

sort user.dat | uniq > user.out
mv -f user.out user.dat

sqlite3 ebayD.db < create.sql

sqlite3 ebayD.db < query1.sql
sqlite3 ebayD.db < query2.sql
sqlite3 ebayD.db < query3.sql
sqlite3 ebayD.db < query4.sql
sqlite3 ebayD.db < query5.sql
sqlite3 ebayD.db < query6.sql
sqlite3 ebayD.db < query7.sql