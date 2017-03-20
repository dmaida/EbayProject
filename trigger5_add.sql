-- 15. All new bids must be placed at the time which matches the current time of your AuctionBase system.

PRAGMA foreign_keys = ON;
drop TRIGGER if exists onTime_bid;
CREATE TRIGGER onTime_bid
after INSERT on bid
for each row
when New.time != (select CurrentTime.currtime from CurrentTime) 
begin
select raise(rollback, 'Bid amount must be placed at same time as current time.');
end;
