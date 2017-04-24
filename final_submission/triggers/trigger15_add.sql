-- 15. All new bids must be placed at the time which matches the current time of your AuctionBase system.

PRAGMA foreign_keys = ON;
drop TRIGGER if exists trigger_15;
CREATE TRIGGER trigger_15
after INSERT on Bid
for each row
when julianday(New.currtime) != (select julianday(currtime) from CurrentTime)
begin
  select raise(rollback, 'Wrong time!');
end;
