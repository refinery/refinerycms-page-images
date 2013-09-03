# Page Images Engine for Refinery CMS

## About

Page Images allows you to relate one or more images to any page in Refinery which makes it really easy for you to create simple image galleries with lightbox style popups on the front end page views.

## Requirements

* refinerycms >= 2.0.0

## Features

* Ability to select one or more images from the image picker and relate them to a page
* Reordering support, simply drag into order
* Optionally include captions with each image.

## Install

Add this line to your applications `Gemfile`

```ruby
gem 'refinerycms-page-images', '~> 2.0.0'
```

Next run

```bash
bundle install
rails generate refinery:page_images
rake db:migrate
```

Now when you start up your Refinery application, edit a page and there should be a new "Images" tab.

# Deploying to Heroku

In order to properly precompile assets on Heroku, config vars be present in the environment during slug compilation. 

```bash
heroku labs:enable user-env-compile -a myapp
```

otherwise you may experience the following error:
```
could not connect to server: Connection refused
Is the server running on host "127.0.0.1" and accepting
TCP/IP connections on port 5432?
```


["More Details"](https://devcenter.heroku.com/articles/labs-user-env-compile)

## Enable Captions

You can enable captions using an initializer containing the following configuration:

```ruby
Refinery::PageImages.captions = true
```

By default, captions are WYM editors. Prefer `textarea`s ? Gotcha :

```ruby
Refinery::PageImages.wysiwyg = false
```

## Usage

`app/views/refinery/pages/show.html.erb`

If you don't have this file then Refinery will be using its default. You can override this with

```bash
rake refinery:override view=refinery/pages/show
```

```erb
<% content_for :body_content_right do %>
  <ul id='gallery'>
    <% @page.images.each do |image| %>
      <li>
        <%= link_to image_tag(image.thumbnail("200x200#c").url), image.thumbnail("900x600").url %>
      </li>
   <% end %>
  </ul>
<% end %>
<%= render :partial => "/refinery/content_page" %>
```

If you have enabled captions, you can show them like this

```erb
<% content_for :body_content_right do %>
  <ul id='gallery'>
    <% @page.images.each_with_index do |image, index| %>
      <li>
        <%= link_to image_tag(image.thumbnail("200x200#c").url), image.thumbnail("900x600").url %>
        <span class='caption'><%=raw @page.caption_for_image_index(index) %></span>
      </li>
   <% end %>
  </ul>
<% end %>
<%= render :partial => "/refinery/content_page" %>
```

## Screenshot

![Refinery CMS Page Images Screenshot](http://refinerycms.com/system/images/0000/1736/refinerycms-page-images.png)
