-- 9. A user may not bid on an item he or she is also selling. (TRIGGER):

/*
Here we want to check that the userID from the Bid table against
userID in the Item table. If the userID and SellerID are equal raise an error.
*/

PRAGMA foreign_keys = ON;
drop trigger if exists trigger_1;
CREATE TRIGGER trigger_1
after insert on Bid
for each row
when select * from Bid natural join Item where (Bid.userID == Item.SellerID)
begin
select raise(rollback, 'User may not bid on an item they are selling.');
end
