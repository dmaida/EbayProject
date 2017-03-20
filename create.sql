DROP TABLE if exists Item;
DROP TABLE if exists User;
DROP TABLE if exists Category;
DROP TABLE if exists Bid;
DROP TABLE if exists CurrentTime;

CREATE TABLE Item(
                    itemID integer PRIMARY KEY,
                    name varchar,
                    currently money,
                    buy_price money,
                    first_bid money,
                    started timestamp,
                    ends timestamp,
                    SellerID string references User,
                  	description varchar(4000));

CREATE TABLE User(
                    userID varchar PRIMARY KEY,
                  	rating integer,
                  	location varchar,
                  	country varchar);

CREATE TABLE Category(
                    itemID integer,
                    name varchar,
                    PRIMARY KEY (itemID, name),
                    FOREIGN KEY(itemID) references Item(itemID));

CREATE TABLE Bid(
                    itemID integer,
                 	userID varchar,
                    time timestamp,
                 	amount money,
                 	PRIMARY KEY (itemID, time),
                 	FOREIGN KEY(itemID) references Item(itemID),
                 	FOREIGN KEY(userID) references User(userID));

CREATE TABLE CurrentTime(currtime string PRIMARY KEY);
INSERT into CurrentTime values ('2001-12-20 00:00:01');
SELECT currtime from CurrentTime;
