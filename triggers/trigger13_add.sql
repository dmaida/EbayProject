--13. In every auction, the Number_of_Bids attribute corresponds to the actual number
--of bids for that particular item. (TRIGGER)

PRAGMA foreign_keys = ON;
drop trigger if exists trigger_13;

CREATE TRIGGER trigger_13
AFTER INSERT ON Bid

WHEN Item.number_of_bids <> (select count(itemID) as num_bids from Bid where Bid.itemID = New.itemID)
BEGIN
	UPDATE Item
	SET number_of_bids = num_bids
	WHERE itemID = New.itemID;
END;
