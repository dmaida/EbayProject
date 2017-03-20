/* 8. The Current_Price of an item must always match the Amount of the most recent bid for
that item. (TRIGGER)
*/

PRAGMA foreign_keys = ON;
drop trigger if exists trigger_8;
CREATE TRIGGER trigger_8
after insert on Bid
for each row
when (select * from (select Item.itemID, Item.currently, max(Bid.amount) as maxBid from Item join Bid on (Item.itemID == Bid.itemID) group by Item.itemID) where (currently != maxBid))
begin
select raise(rollback, 'Current price of item must match Amount of most recent bid.');
end;
