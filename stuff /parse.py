import os
import sys
import re
#from lxml import etree, objectify
from xml.etree import ElementTree
#import requests
#from bs4 import BeautifulSoup
sep = "|"
#def process_cash(s):
	# take out the $ and the , and the .
	# string representing integer number of CENTS

def parse(xml_file_loc):
	tree = parse(xml_file_loc) # ElementTree instance
	with open("items.dat", "a") as fp: #items.dat is the file you want to create or add stuff to
		for item in tree.iter("Item"): # this is returning an ElementTree node thing. it has children
			# name, category, whatever whatever
			name = item.find("Name").text
			#currently = process_cash(item.find("Currently").text)
			# ... # get the category
			# ... # get the other stuff
			#name, category, whatevr, whtever = 1, 2, 3, 3 # these are actually going to be STRINGSSS
			#fp.write(name + sep + category + sep + whatevr + sep + "\n")
			fp.write(name)


file_name = "items-0.xml"
full_file = os.path.abspath(os.path.join('ebay_data', file_name))
parse(full_file)
