-- 11. No auction may have a bid before its start time or after its end time. (TRIGGER)

PRAGMA foreign_keys = ON;
drop trigger if exists trigger_11;
CREATE TRIGGER trigger_11
before INSERT on Bid
for each row
when
  (julianday(New.currtime) > (select julianday(ends)
  from Item where itemID = New.itemID))
  OR
  (julianday(New.currtime) < (select julianday(started)
  from Item where itemID = New.itemID))

begin
  select raise(rollback, 'Expired! ... OR DOESNT EXIST!');
end;
