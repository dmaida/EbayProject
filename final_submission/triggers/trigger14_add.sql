-- 14. Any new bid for a particular item must have a higher 
-- amount than any of the previous bids for that particular item. (TRIGGER)

PRAGMA foreign_keys = ON;

drop TRIGGER if exists trigger_14;
create TRIGGER trigger_14
after INSERT on bid
for each row
when New.Amount <= (select currently from Item where Item.itemID = New.itemID)
begin
select raise(rollback, 'Bid amount must be greater than the current bid.');
end;
