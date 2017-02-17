select itemID from(
	select itemID, max(currently)
	from Item);