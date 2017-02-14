"""
The following code is parsing stuff

"""

from lxml import etree
import requests
rawpage = request.get(url) #only for webpages, can ignore
root = etree.fromstring(rawpage.content) #creates an xml element tree, with root being the top node
#for loop iterates through each node (depth first) and you can print the tag, attribute or text associated with each tag
for node in root.iter():
	print(node.tag,node.attrib,node.text) #prints tag, attribute, and text for each xml tag



"""
The following code creates database and table if it doesn't exist, otherwise connects to db

"""

if 'Secrets_of_the_stars.db' not in os.listdir('./'):
		Sagan_db = sqlite3.connect('Secrets_of_the_stars.db')
		print('Database created successfully')
		Sagan_db.execute('''CREATE TABLE NGC
						 (ID INT PRIMARY KEY NOT NULL,
						  NAME    TEXT        NOT NULL,
						  Alt_Name TEXT,
						  Object_Type TEXT,
						  Constellation TEXT,
						  RA            TEXT,
						  Declination   TEXT,
						  Appar_Mag     REAL,
						  Description   TEXT,
						  Image         TEXT);''')
		print('Table Created')
	else:
		Sagan_db = sqlite3.connect('Secrets_of_the_stars.db')
		print('Database Connected')
Add Comment Collapse



"""
Short function for adding to table in db

to add to your table, change NGC in execute to your table name
and the ?'s in the first tuple correspond to each value you are inserting into your table
"""

def add_to_db(db,data_list):
	"""
	Adds a pre-formatted list of data to a previously created table
	Args: db - Previously created database
	data_list - list of parsed and formatted data
	Will not return anything.  Prints a success message once item added to table
	"""
	data_tuple = tuple(data_list)
	db.execute('insert into NGC values (?,?,?,?,?,?,?,?,?,?)',tuple(data_list))
	db.commit()
	print('Added ',data_list[0], data_list[1], ' to table')
