-- 9. A user may not bid on an item he or she is also selling. (TRIGGER):

PRAGMA foreign_keys = ON;
drop trigger if exists trigger_9;
CREATE TRIGGER trigger_9
before INSERT on Bid
for each row

when New.userID = (select SellerID from Item where New.itemID = Item.itemID)
begin
  select raise(rollback, 'Bidder cannot be the seller!');
end;
