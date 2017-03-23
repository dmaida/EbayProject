Name: Steven Call, Daniel Maida, Nazar Stelmakh
Email: steven.call@wsu.edu, daniel.maida@wsu.edu, nazar.stelmakh@wsu.edu

Description: The .py program takes .xml files as input and 
parses those files into 4 different .dat files. From that
the create.sql file converts those .dat files into a database
(.db) in which you pull queries from. This database represents
a miniture Ebay. We added triggers that do an assortment of 
control functions for the database as well some constraints
for the database. The details for each are held in the
constraints.txt file. The constraints_verify.sql is a couple of
queries that verify some constraints (No output is given on 
success).

Run/Compile: In the terminal run the runParser.sh file
		
		bash$ ./runParser.
		bash$ ./createDatabase

Note: The default folder for the parser to look at is set to 
/usr/class/cs351/project/ebay_data/items-*.xml
from the argo server


Archive:
fileParser.py................parsing program that converts .xml to .dat
create.sql..................sql program that converts .dat files to .db
runParser.sh.................shell script to execute necessary programs
createDatabase.sh........................converts .dat files to one .db
load.txt................................................file to load db
triggerN_add.sql.............................all triggers to control db
triggerN_drop.sql.................................file to drop triggers
constraints.txt............English description of all constraints added
constraints_verify.sql.................verifies constraints are working
README.txt....................................................this file

