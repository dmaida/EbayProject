-- 16. The current time of your AuctionBase system can only 
-- advance forward in time, not backward in time (TRIGGER)

PRAGMA foreign_keys = ON;
drop trigger if exists trigger_16;
CREATE TRIGGER trigger_16
before UPDATE on CurrentTime
for each row

when julianday(New.time) < (select julianday(currtime)
  from CurrentTime)

begin
  select raise(rollback, 'Out of time bounds!');
end;


