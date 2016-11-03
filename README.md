# Link Cubby

#### Store all your links. 

[Production Application](http://link-cubby.herokuapp.com/)

![screenshot](http://i.imgur.com/PXtjAXD.png)

### Description

A CRUD Rails app with authentication and responsive Javascript. This app uses Javascript and jQuery on the frontend, with a Rails API serving up the content on the backend. 

### Usage

* Create a new account by entering an email address and password. Once logged in, you'll 
  be redirected to the links index page.
  
* Create new links: Add a new link to the list by using the form in the upper left hand
  corner.

* Update read status: Once link is added to the list, use the
  'Mark as Read'/'Mark as Unread' buttons to toggle the status of that link.

* Edit links: To change the title or url of a link, click the title or url and start
  editing. Changes will be saved automatically when you click away.

* Search: Start typing in the search box to filter the links list.

### Installation

1. `git clone git@github.com:saylerb/link-cubby.git`

1. `cd link-cubby`

1. `bundle install`

1. `rails db:setup`

1. `rails s`

### Testing

* Run `rspec` to run the test suite. 
