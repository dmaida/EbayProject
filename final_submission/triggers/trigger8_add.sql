-- 8. The Current_Price of an item must always match the Amount of the most recent bid for that item. (TRIGGER)

PRAGMA foreign_keys = ON;
drop trigger if exists trigger_8;
CREATE TRIGGER trigger_8
after INSERT on Bid
for each row
when New.amount > (select currently from Item where Item.itemID = New.itemID)
begin
  UPDATE Item
  SET currently = New.Amount
  WHERE itemID = New.ItemID;
end;
