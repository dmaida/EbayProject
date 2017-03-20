/*
Therefore, you need to verify that the initial data actually satisfies your Referential
Integrity constraints through some alternative means. Write a SELECT statement for
each Referential Integrity constraint that returns an empty result if and only if the
constraint holds. Create a file called constraints_verify.sql with all of your constraintverifying
SELECT statements:
*/

-- Referential Integrity

--All sellers and bidders must already exist as users.
select userID from Bid where userID not in (select userID from User); /* SELECT statement verifying Referential Integrity #2*/
select SellerID from Item where sellerID not in (select userID from User); /* SELECT statement verifying Referential Integrity #2*/

--Every bid must correspond to an actual item.
select itemID from Bid where itemID not in (select itemID from Item); /* SELECT statement verifying Referential Integrity #4*/

--The items for a given category must all exist.
select itemID from Category where itemID not in (select itemID from Item); /* SELECT statement verifying Referential Integrity #5*/


-- Row-Level Check



-- Triggers
