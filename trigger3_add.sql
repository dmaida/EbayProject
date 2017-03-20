-- 12. No user can make a bid of the same amount to the same item more than once.

PRAGMA foreign_keys = ON;
drop TRIGGER if exists multipleBid_amount;
CREATE TRIGGER multipleBid_amount
after INSERT on bid
for each row
when New.Amount <= (select currently from Item where Item.ItemID = New.ItemID)
begin
select raise(rollback, 'Bid amount must be greater than the current bid.');
end;
