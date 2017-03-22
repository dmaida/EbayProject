select count(distinct userID) from(
	select userID
	from User, Item 
	where userID = sellerID and rating > 1000);
