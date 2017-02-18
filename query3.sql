select count(itemID) from (
	select itemID
	from Category
	group by itemID
	Having count(name) = 4);