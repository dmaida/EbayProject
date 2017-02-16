DROP TABLE if exists Item;
DROP TABLE if exists User;
DROP TABLE if exists Category;
DROP TABLE if exists Bid;
DROP TABLE if exists ItemSeller;
DROP TABLE if exists ItemCategory;

CREATE TABLE Item(	itemID int PRIMARY KEY,
					name varchar(100) NOT NULL,
                  	buy_price decimal(8,2),
                  	first_bid decimal(8,2) NOT NULL,
                  	started timestamp NOT NULL,
                  	ends timestamp NOT NULL,
                  	description varchar(4000) NOT NULL,
                  	currently decimal(8,2) NOT NULL);

CREATE TABLE User(	userID varchar(50) PRIMARY KEY,
                  	rating int NOT NULL,
                  	location varchar(50),
                  	country varchar(50));

CREATE TABLE Category(	item_id int,
                        name varchar(30),
                        FOREIGN KEY(item_id) references Item(itemID),

CREATE TABLE Bid(	item_id int,
                 	time timestamp,
                 	user_id varchar(50),
                 	amount decimal(8,2),
                 	PRIMARY KEY (item_id, time),
                 	FOREIGN KEY(item_id) references Item(itemID),
                 	FOREIGN KEY(user_id) references User(userID));

LOAD DATA LOCAL INFILE 'item.dat' INTO TABLE Item
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"';

LOAD DATA LOCAL INFILE 'user.dat' INTO TABLE User
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"';

LOAD DATA LOCAL INFILE 'category.dat' INTO TABLE Category
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"';

LOAD DATA LOCAL INFILE 'bid.dat' INTO TABLE Bid
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"';
