DROP TABLE if exists Item;
DROP TABLE if exists User;
DROP TABLE if exists Category;
DROP TABLE if exists Bid;

CREATE TABLE Item(	
                    itemID integer,
                    name varchar,
                    SellerID varchar,
					          first_bid varchar,
                  	buy_price varchar,
                  	currently varchar,
                  	started timestamp,
                  	ends timestamp,
                  	description varchar(4000));

CREATE TABLE User(	
                    userID varchar,
                  	rating integer,
                  	location varchar,
                  	country varchar);

CREATE TABLE Category(	
                    itemID integer,
                    name varchar,
                    PRIMARY KEY (itemID, name)
                    FOREIGN KEY(itemID) references Item(itemID));

CREATE TABLE Bid(	
                    itemID integer,
                 	  userID varchar,
                    time timestamp,
                 	  amount money,
                 	  PRIMARY KEY (itemID, time),
                 	  FOREIGN KEY(itemID) references Item(itemID),
                 	  FOREIGN KEY(userID) references User(userID));


.separator |

.import item.dat Item

.import user.dat User

.import category.dat Category

.import bid.dat Bid
