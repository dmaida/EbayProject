-- 12. No user can make a bid of the same amount to the same item more than once.

PRAGMA foreign_keys = ON;
drop TRIGGER if exists multipleBid_amount;
CREATE TRIGGER multipleBid_amount
before INSERT on Bid
for each row
when New.Amount <= (select currently from Item where Item.itemID = New.itemID)
begin
select raise(rollback, 'Bid amount must be greater than the current bid.');
end;
