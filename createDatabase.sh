sqlite3 auctions.db < create.sql
sqlite3 auctions.db < load.txt
sqlite3 auctions.db < constraints_verify.sql

sqlite3 auctions.db < triggers/trigger8_add.sql
sqlite3 auctions.db < triggers/trigger9_add.sql
sqlite3 auctions.db < triggers/trigger11_add.sql
sqlite3 auctions.db < triggers/trigger12_add.sql
sqlite3 auctions.db < triggers/trigger13_add.sql
sqlite3 auctions.db < triggers/trigger14_add.sql
sqlite3 auctions.db < triggers/trigger15_add.sql
sqlite3 auctions.db < triggers/trigger16_add.sql

rm *.dat

: <<'END'
sqlite3 auctions.db < queries/query1.sql
sqlite3 auctions.db < queries/query2.sql
sqlite3 auctions.db < queries/query3.sql
sqlite3 auctions.db < queries/query4.sql
sqlite3 auctions.db < queries/query5.sql
sqlite3 auctions.db < queries/query6.sql
sqlite3 auctions.db < queries/query7.sql
END
echo 'Success'
