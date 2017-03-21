-- 14. Any new bid for a particular item must have a higher amount than any of the previous bids for that particular item. (TRIGGER)

PRAGMA foreign_keys = ON;

drop TRIGGER if exists price_constraint;
create TRIGGER price_constraint
after INSERT on bid
for each row
when New.Amount <= (select currently from Item where Item.ItemID = New.ItemID)
begin
select raise(rollback, 'Bid amount must be greater than the current bid.');
end;
