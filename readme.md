# Page Images Engine for Refinery CMS

## About

This engine does two main things:

1. Adds a relationship between pages and images
2. A new "Images" tab will appear when editing a page in the "Pages" section

This allows you to relate one or more images to any page in Refinery which makes it really easy for you to create simple image galleries with lightbox style popups on the front end page views.

## Install

Add this line to your applications `Gemfile`

    gem 'refinerycms-page-images', '= 0.9.4'
    
Next run

    bundle install
    rails g refinerycms_page_images
    rake db:migrate
    
Now when you start up your Refinery application, edit a page and there should be a new "Images" tab.

## Screenshot

![Refinery CMS Page Images Screenshot](http://refinerycms.com/system/images/0000/1736/refinerycms-page-images.png)