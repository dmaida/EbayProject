#!/usr/bin/env python

import sys; sys.path.insert(0, 'lib') # this line is necessary for the rest
import os                             # of the imports to work!

import web
import sqlitedb
from jinja2 import Environment, FileSystemLoader
from datetime import datetime

###########################################################################################
##########################DO NOT CHANGE ANYTHING ABOVE THIS LINE!##########################
###########################################################################################

######################BEGIN HELPER METHODS######################

# helper method to convert times from database (which will return a string)
# into datetime objects. This will allow you to compare times correctly (using
# ==, !=, <, >, etc.) instead of lexicographically as strings.

# Sample use:
# current_time = string_to_time(sqlitedb.getTime())

def string_to_time(date_str):
  return datetime.strptime(date_str, '%Y-%m-%d %H:%M:%S')

# helper method to render a template in the templates/ directory
#
# `template_name': name of template file to render
#
# `**context': a dictionary of variable names mapped to values
# that is passed to Jinja2's templating engine
#
# See curr_time's `GET' method for sample usage
#
# WARNING: DO NOT CHANGE THIS METHOD
def render_template(template_name, **context):
  extensions = context.pop('extensions', [])
  globals = context.pop('globals', {})

  jinja_env = Environment(autoescape=True,
      loader=FileSystemLoader(os.path.join(os.path.dirname(__file__), 'templates')),
      extensions=extensions,
      )
  jinja_env.globals.update(globals)

  web.header('Content-Type','text/html; charset=utf-8', unique=True)

  return jinja_env.get_template(template_name).render(context)

#####################END HELPER METHODS#####################

# first parameter => URL, second parameter => class name
urls = (
  '/currtime', 'curr_time',
  '/selecttime', 'select_time',
  '/add_bid', 'add_bid',
  '/search', 'search',
  '/bid_details', 'bid_details',
  '/add_user', 'add_user'
)
class add_user:
    def GET(self):
      return render_template('add_user.html')

    def POST(self):
        post_params = web.input()
        userID = post_params['userID']
        location = post_params['location']
        country = post_params['country']
        if (userID == '') or (location == '') or (country == ''):
            return render_template('add_user.html',
              message = 'You must fill out every field'
            )
        user_row = sqlitedb.getUserById(userID);
        if user_row != None:
          return render_template('add_user.html', message = 'This user ID is already taken.')

        sqlitedb.addUser(userID, location, country)
        return render_template(
          'add_user.html',
          message = 'Success!' + '(' + userID + ')' +'has been added.'
        )

class bid_details:
    def GET(self):
        itemID = web.input(id='web')
        details = web.websafe(itemID.id)

        q = "select * from Item where itemID = %s" % (details)
        r = "select name from Category where itemID = %s" % (details)
        s = "select userID, amount, currtime from Bid where itemID = %s ORDER BY Bid.amount DESC" % (details)

        Q = sqlitedb.query(q)
        R = sqlitedb.query(r)
        S = sqlitedb.query(s)

        current_time = sqlitedb.getTime()

        item_row = sqlitedb.getItemById(details)

        winner = False
        if (string_to_time(item_row.ends) <= string_to_time(current_time)):
            #winner = sqlitedb.getWinnerId(details)
            winner = True

        return render_template('bid_details.html', Item = Q, Cat = R, Bid = S, Win = winner)

class search:
    def GET(self):
        return render_template('search.html')

    def POST(self):
        post_params = web.input()

        itemID = post_params['itemID']
        min_price = post_params['min_price']
        max_price = post_params['max_price']
        category = post_params['category']
        description = post_params['description']
        status = post_params['status']

        criteria = {}

        if(itemID != ''):
          criteria['Item.itemID'] = itemID

        result = sqlitedb.getItems(criteria, category, description, min_price, max_price, status)

        return render_template('search.html', search = result)

    #################### TESTING ################################

        ##displayCat = sqlitedb.getCategory(category)
        ##return render_template('search.html', search = displayCat)


class curr_time:
  # A simple GET request, to '/currtime'
  #
  # Notice that we pass in `current_time' to our `render_template' call
  # in order to have its value displayed on the web page
  def GET(self):
    current_time = sqlitedb.getTime()
    return render_template('curr_time.html', time = current_time)



class select_time:
  # Another GET request, this time to the URL '/selecttime'
  def GET(self):
    return render_template('select_time.html')

  # A POST request
  #
  # You can fetch the parameters passed to the URL
  # by calling `web.input()' for **both** POST requests
  # and GET requests
  def POST(self):
    post_params = web.input()

    MM = post_params['MM']
    dd = post_params['dd']
    yyyy = post_params['yyyy']
    HH = post_params['HH']
    mm = post_params['mm']
    ss = post_params['ss'];
    enter_name = post_params['entername']


    selected_time = '%s-%s-%s %s:%s:%s' % (yyyy, MM, dd, HH, mm, ss)
    update_message = '(Hello, %s. Previously selected time was: %s.)' % (enter_name, selected_time)

    # save the selected time as the current time in the database
    sqlitedb.setTime(selected_time)

    # Here, we assign `update_message' to `message', which means
    # we'll refer to it in our template as `message'
    return render_template('select_time.html', message = update_message)



class add_bid:
  # A GET request to the URL '/add_bid'
  def GET(self):
    return render_template('add_bid.html')

  # A POST request to the URL '/add_bid'
  def POST(self):
    post_params = web.input()

    itemID = post_params['itemID']
    price = post_params['price']
    userID = post_params['userID']
    current_time = sqlitedb.getTime()

    ### Many ways to fail... #######################################

    # (1) All fields must be filled
    if (itemID == '') or (price == '') or (userID == ''):
      return render_template('add_bid.html',
        message = 'You must fill out every field'
      )

    item_row = sqlitedb.getItemById(itemID)

    # (2) There must be an item with that ID
    if item_row == None:
      return render_template('add_bid.html',
        message = 'There are no items with that ID'
      )

    # (3) Users can't bid on closed auction items
    if (string_to_time(item_row.ends) <= string_to_time(current_time)):
      return render_template('add_bid.html',
        message = 'That auction is already closed'
      )

    # (4) UserID must correspond to an existing user in User table
    user_row = sqlitedb.getUserById(userID);
    if user_row == None:
      return render_template('add_bid.html',
        message = 'There are no users with that ID'
      )

    # (5) Don't accept bids <= current highest bid

    if float(price) <= float(item_row.currently):
      return render_template('add_bid.html',
        message = 'You must make a bid higher than the current price')

    ### ... but it's possible to succeed :P ########################

    # A bid at the buy_price closes the auction
    if (price >= item_row.buy_price):
      # Update ends to current_time
      sqlitedb.updateItemEndTime(itemID, current_time);
      return render_template(
        'add_bid.html',
        message = 'Congratulations! You just closed that auction by making a bid at or above the buy price'
      )

    # Add bid to Bid table in db
    sqlitedb.addBid(itemID, price, userID, current_time)

    return render_template(
      'add_bid.html',
      message = 'Success! You\'ve just placed a bid on ' + item_row.name + '(' + itemID + ')'
    )


###########################################################################################
##########################DO NOT CHANGE ANYTHING BELOW THIS LINE!##########################
###########################################################################################

if __name__ == '__main__':
  web.internalerror = web.debugerror
  app = web.application(urls, globals())
  app.add_processor(web.loadhook(sqlitedb.enforceForeignKey))
  app.run()
