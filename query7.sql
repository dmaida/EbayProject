select count(distinct name) from(
	select name
	from Bid, Category
	where Category.itemID = Bid.itemID and amount > 100);
	