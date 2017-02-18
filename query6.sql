select count(distinct sellerID) from(
	select sellerID
	from Item, Bid
	where sellerID = userID);