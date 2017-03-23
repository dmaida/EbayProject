-- Referential Integrity

--All sellers and bidders must already exist as users.
select userID from Bid where userID not in (select userID from User); /* SELECT statement verifying Referential Integrity #2*/
select SellerID from Item where sellerID not in (select userID from User); /* SELECT statement verifying Referential Integrity #2*/

--Every bid must correspond to an actual item.
select itemID from Bid where itemID not in (select itemID from Item); /* SELECT statement verifying Referential Integrity #4*/

--The items for a given category must all exist.
select itemID from Category where itemID not in (select itemID from Item); /* SELECT statement verifying Referential Integrity #5*/
