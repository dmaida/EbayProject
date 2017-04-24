--13. In every auction, the Number_of_Bids attribute corresponds to the actual number
--of bids for that particular item. (TRIGGER)

PRAGMA foreign_keys = ON;
drop trigger if exists trigger_13;

CREATE TRIGGER trigger_13
AFTER INSERT ON Bid

when New.amount > (select currently from Item where Item.itemID = New.itemID)

begin
	UPDATE Item
	Set number_of_bids = (select count(itemID) from Bid where Bid.itemID = New.itemID)
	WHERE Item.itemID = New.itemID;
end;
