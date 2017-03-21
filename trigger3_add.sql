-- 11. No auction may have a bid before its start time or after its end time. (TRIGGER)

PRAGMA foreign_keys = ON;
drop TRIGGER if exists time_constraint;
CREATE TRIGGER time_constraint
after INSERT on bid
for each row
when julianday(New.Time) > (select julianday(ends) from item where itemid=New.ItemID) or (select buy_price==currently from item where itemid=New.ItemID)
begin
select raise(rollback, 'This auction is closed.');
end;
