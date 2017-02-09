import os
import sys
import re
from lxml import etree, objectify
import requests
from bs4 import BeautifulSoup


class Performers:
	name = None
	activeYears = None
	startYear = None
	endYear = None
	def __init__(self, name):
		self.name = name

def findPerformers():
	pageInfo = getPage("List_of_rock_and_roll_performers")            # This sends the search term we want to use while looking through the wikipedia pages
	irrelevantData = "(?!List of musicians by genre|List of rock musicians by genre|Rock and Roll|Category)" # This adds things that are not the data we are looking for.
	performerNames = re.findall(r"\[\[("+irrelevantData+".*?)\]\]", pageInfo)     # This uses the last variable to exclude the capture of data we arent looking for
	return performerNames  								# Gives the performerNames of performers and bands

def etreeAdd(root, performers):
	etree_performers = etree.SubElement(root, "performers")  # by adding this you add all elements that are within performers
	etree_name = etree.SubElement(etree_performers, "name")  # add the tag "name" to the etree
	if performers.name is not None:							 # If a name was found and collected
		etree_name.text = " " + performers.name + " "		 # Enter the name in the etree with a space before and after name

	etree_activeYears = etree.SubElement(etree_performers, "activeYears")  # add the tag "activeYears" to the etree 
	if performers.activeYears is not None:      						   # if the "active years" or year music began is found
		etree_activeYears.text = " " + performers.activeYears + " "		   # Enter the date in the etree with a space before and after

	etree_startYear = etree.SubElement(etree_performers, "startYear")   # add the tag "startYear" to the etree
	if performers.startYear is not None:								# if the "start year" or year born is found
		etree_startYear.text = " " + performers.startYear + " " 		# Enter the date in the etree with a space before and after

	etree_endYear = etree.SubElement(etree_performers, "endYear")		# add the tag "endYear" to the etree
	if performers.endYear is not None:									# if the "end year" or year they died is found
		etree_endYear.text = " " + performers.endYear + " "   			# Enter the date in the etree with a space before and after

def getData(performerNames):
	RockandRoll = []  					# creates a list to store the information in
	for name in performerNames: 		# for loop to run through all the names
		performers = Performers(name)   # create performers object to store data that will be collected
		pageInfo = getPage(name)  		# searches through wikipedia page to get data if possible
		if pageInfo is not None: 		# if some data is found
			re_activeYears = re.search("years_active.*?(\d{3,4})", pageInfo) # look for years_active tage and a date after the tag
			re_startYear = re.search("birth_date.*?(\d{3,4})", pageInfo)     # look for birth_date tage and a date after the tag
			re_endYear = re.search("death_date.*?(\d{3,4})", pageInfo) 		 # look for death_date tage and a date after the tag
			performers.activeYears = regExChange(re_activeYears)  			 # call the function to change the regex to string
			performers.startYear = regExChange(re_startYear)   				 # call the function to change the regex to string
			performers.endYear = regExChange(re_endYear) 					 # call the function to change the regex to string
			RockandRoll.append(performers)   								 # add the new strings to the list of RockandRoll
	return RockandRoll 														 # return the list

def getPage(wikiPage):
	#Searches for the specific title given for a wikipedia page with same title and gets the content.
	performers_page = "https://en.wikipedia.org/w/api.php?action=query&prop=revisions&rvprop=content&titles="+wikiPage+"&format=xml"
	performers_res = requests.get(performers_page)
	soup = BeautifulSoup(performers_res.text, "xml")  # using soups built in function takes the content from the page
	if soup.revisions is None:                  # I believe this is checking if it gathered any data if not 
		return None 							# then return nothing.
	else:
		return soup.revisions.getText()  # Otherwise return the data as text that was recovered from the wikipedia site

def performerList(performers):
	print performers.name + "--------> ",  # prints the name of group or artist, use a comma to keep print on same line

	if performers.activeYears is not None:  # if information is stored in activeYears
		print "Year started music:",        # print this statement
		print performers.activeYears,". ", # and print the date saved and .

	if performers.startYear is not None:    # if information is stored in startYear
		print "Life span of artist:",		# print this statement
		print performers.startYear, "-", 	# and print the date saved and - to seperate from date of death

	if performers.endYear is not None: 		# if information is stored in endYear
		print performers.endYear 			# print the date saved
	else:
		print ""  # to add newline 			# if no information is found print new line and move on


def regExChange(re_Date):
	if re_Date is not None: 				# if there is a date passed in
		if re_Date.group(1) is not None:  	# if this regex was matched and data saved
			return re_Date.group(1) 		# return this group
		if re_Date.group(2) is not None:  	# if this regex was matched and data saved
			return re_Date.group(2) 		# return this group
		elif re_Date.group(3) is not None:  # if this regex was matched and data saved
			return re_Date.group(3)			# return this group
	else:
		return None 						# return nothing if no regex was matched


def main():
	root = etree.Element("RockandRoll")   # inititate etree xml
	performerNames = findPerformers()     # call findPerformers and save the names to performerNames
	print "Collecting information about Rock and Roll Performers: "
	RockandRoll = getData(performerNames) # call getData on the names saved and save the data to RockandRoll
	for performers in RockandRoll: 		  # for each name in RockandRoll
		performerList(performers) 		  # call performerList so that you can print the data
		etreeAdd(root, performers) 		  # add the performer to the etree
	xmlFile = open("RockandRoll.xml", "w")  # create the xml file and assign xmlFile to it
	xmlFile.write(etree.tostring(root, pretty_print=True))  # take xml that was created and put into xmlFile (RockandRoll.xml)
	print "*****End of Information Collected***** \n"

if __name__ == "__main__":   		# run program
	main()
