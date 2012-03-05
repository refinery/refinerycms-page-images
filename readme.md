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

## Enable Captions

You can enable captions using an initializer containing the following configuration:

```ruby
Refinery::PageImages.captions = true
```

## Usage

`app/views/refinery/pages/show.html.erb`

```erb
<% content_for :body_content_right do %>
  <ul id='gallery'>
    <% @page.images.each do |i| %>
      <li>
        <%= link_to image_tag(i.thumbnail("200x200#c").url), i.thumbnail("900x600").url %>
      </li>
   <% end %>
  </ul>
<% end %>
<%= render :partial => "/refinery/content_page" %>
```

## Screenshot

![Refinery CMS Page Images Screenshot](http://refinerycms.com/system/images/0000/1736/refinerycms-page-images.png)
