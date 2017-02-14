import os
from xml.etree import ElementTree

def get_names(file_path):
    dom = ElementTree.parse(file_path)
    itemName = dom.findall("Item/Name")
    for i in itemName:
        print(i.text)

def get_ID(file_path):
    dom = ElementTree.parse(file_path)
    itemID = dom.findall("Item")
    for i in itemID:
        print(i.attrib)

def get_category(file_path):
    dom = ElementTree.parse(file_path)
    itemCat = dom.findall("Item/Category")
    for i in itemCat:
        print(i.text, '\n')

def get_currently(file_path):
    dom = ElementTree.parse(file_path)
    item_currently = dom.findall("Item/Currently")
    for i in range(len(item_currently)):
        print(i, item_currently[i].text)


file_name = "items-0.xml"
full_file = os.path.abspath(os.path.join('ebay_data', file_name))
get_names(full_file)
#get_ID(full_file)
#get_category(full_file)
#get_currently(full_file)
