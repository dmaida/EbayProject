Name: Steven Call, Daniel Maida, Nazar Stelmakh
Email: steven.call@wsu.edu, daniel.maida@wsu.edu, nazar.stelmakh@wsu.edu

Description: The .py program takes .xml files as input and 
parses those files into 4 different .dat files. From that
the create.sql file converts those .dat files into a database
(.db) in which you pull queries from. This database represents
a miniture Ebay. Finally this program runs 7 different queries
on the data base and prints them to the terminal 

Run/Compile: In the terminal run the runParser.sh file
		
		bash$ ./runParser.

Note: The default folder for the parser to look at is set to 
/usr/class/cs351/project/ebay_data/items-*.xml
from the argo server


Archive:
fileParser.py................parsing program that converts .xml to .dat
create.sql..................sql program that converts .dat files to .db
runParser.sh.................shell script to execute necessary programs
load.txt................................................file to load db
query[1-7].sql................................test queries to run on db
design.pdf................................................schema design
README.txt....................................................this file

