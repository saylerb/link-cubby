# Link Cubby (aka ThoughtBox)

#### Store all your links. 

[Production Application](http://link-cubby.herokuapp.com/)

![screenshot](http://i.imgur.com/PXtjAXD.png)

### Description

This is part of assessment for module 4 students at Turing School. The goal is to implement a CRUD
Rails app with authentication and responsive Javascript. This app uses Javascript and jQuery on the frontend,
with a Rails API serving up the content on the backend.

### Usage

* Create new links: Add a new link to the list by using the form in the upper left hand
  corner.

* Update read status: Once link is added to the list, use the
  'Mark as Read'/'Mark as Unread' buttons to toggle the status of that link.

* Edit links: To change the title or url of a link, click the title or url and start
  editing. Changes will be saved automatically when you click away.

* Search: Start typing in the search box to filter the links list.

### Installation

1. `git clone git@github.com:saylerb/thought-box.git`

1. `cd thought-box`

1. `bundle install`

1. `rails db:setup`

1. `rails s`

### Testing

* Run `rspec` to run the test suite. 
