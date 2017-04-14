sqlite3 mini-ebay/AuctionBase.db < create.sql
sqlite3 mini-ebay/AuctionBase.db < load.txt
sqlite3 mini-ebay/AuctionBase.db < constraints_verify.sql

sqlite3 mini-ebay/AuctionBase.db < triggers/trigger8_add.sql
sqlite3 mini-ebay/AuctionBase.db < triggers/trigger9_add.sql
sqlite3 mini-ebay/AuctionBase.db < triggers/trigger11_add.sql
sqlite3 mini-ebay/AuctionBase.db < triggers/trigger12_add.sql
sqlite3 mini-ebay/AuctionBase.db < triggers/trigger13_add.sql
sqlite3 mini-ebay/AuctionBase.db < triggers/trigger14_add.sql
sqlite3 mini-ebay/AuctionBase.db < triggers/trigger15_add.sql
sqlite3 mini-ebay/AuctionBase.db < triggers/trigger16_add.sql

rm *.dat

: <<'END'
sqlite3 AuctionBase.db < queries/query1.sql
sqlite3 AuctionBase.db < queries/query2.sql
sqlite3 AuctionBase.db < queries/query3.sql
sqlite3 AuctionBase.db < queries/query4.sql
sqlite3 AuctionBase.db < queries/query5.sql
sqlite3 AuctionBase.db < queries/query6.sql
sqlite3 AuctionBase.db < queries/query7.sql
END
echo 'Success'
