# Page Images Engine for Refinery CMS

[![Build Status](https://travis-ci.org/refinery/refinerycms-page-images.svg?branch=master)](https://travis-ci.org/refinery/refinerycms-page-images)

## About

Page Images allows you to relate one or more images to any page in Refinery which makes it really easy for you to create simple image galleries with lightbox style popups on the front end page views.

## Requirements

* refinerycms-pages ~> 4.0

## Features

* Ability to select one or more images from the image picker and assign them to a page
* An image can be assigned to more than one page
* Reordering support, simply drag into order
* An image assigned to a page can have a caption.
* An image's caption can be different for different pages

## Install

Add this line to your application's `Gemfile`

```ruby
gem 'refinerycms-page-images', '~> 4.0.0', git: "https://github.com/refinery/refinerycms-page-images", branch: "master"
```

Next run

```bash
bundle install
rails generate refinery:page_images
rake db:migrate
```

Now when you start up your Refinery application, edit a page and there should be a new "Images" tab.

# Deploying to Heroku

Note: the following information about assets on Heroku might be out of date.

In order to properly precompile assets on Heroku, config vars must be present in the environment during slug compilation.

```bash
heroku labs:enable user-env-compile -a myapp
```

otherwise you may experience the following error:
```
could not connect to server: Connection refused
Is the server running on host "127.0.0.1" and accepting
TCP/IP connections on port 5432?
```


[More Details](https://devcenter.heroku.com/articles/labs-user-env-compile)

## Enable Captions

You can enable captions using an initializer containing the following configuration:

```ruby
# app/config/initializers/refinery/page-images.rb
Refinery::PageImages.captions = true
```

By default, captions are WYM editors. Prefer `textarea`s? Gotcha :

```ruby
Refinery::PageImages.wysiwyg = false
```

Note that WYMeditor support requires that you have the extension in your Gemfile:

```ruby
gem 'refinerycms-wymeditor', ['~> 2.0', '>= 2.0.0']
```

## Usage

`app/views/refinery/pages/show.html.erb`

If you don't have this file then Refinery will be using its default. You can override this with

```bash
rake refinery:override view=refinery/pages/show
```

If images have been assigned to a page several objects are available for showing on the page. They are

* `@page.images`: A collection of images assigned to the page.
* `@page.caption_for_image_index(i)` will return the caption (if any) for the i<sup>th</sup> image in @page.images
* `@page.images_with_captions`: A collection of image_with_caption objects with the attributes image: and caption:

```erb
<% content_for :body_content_right do %>
  <ul id='gallery'>
    <% @page.images.each do |image| %>
      <li>
        <%= link_to image_tag(image.thumbnail(geometry: "200x200#c").url),
                    image.thumbnail(geometry: "900x600").url %>
      </li>
   <% end %>
  </ul>
<% end %>
<%= render :partial => "/refinery/content_page" %>
```

If you have enabled captions, you can show them like this

```erb
<% content_for :body_content_right do %>
  <section id='gallery'>
    <% @page.images.each_with_index do |image, index| %>
      <figure>
        <%= link_to image_tag(image.thumbnail(geometry: "200x200#c").url),
                    image.thumbnail(geometry: "900x600").url %>
        <figcaption><%=raw @page.caption_for_image_index(index) %></figcaption>
      </figure>
   <% end %>
  </section>
<% end %>
<%= render :partial => "/refinery/content_page" %>
```
or like this
```erb
<% content_for :body_content_right do %>
  <section id='gallery'>
    <% @page.images_with_captions.each do |iwc| %>
      <figure>
        <%= link_to image_tag(iwc.image.thumbnail(geometry: "200x200#c").url),
                    iwc.image.thumbnail(geometry: "900x600").url %>
        <figcaption><%=raw iwc.caption %></figcaption>
      </figure>
   <% end %>
  </section>
<% end %>
<%= render :partial => "/refinery/content_page" %>
```
## Refinerycms-blog support

Contrary to its name, `refinerycms-page-images` also works with `refinerycms-blog` and adds the functionality to link images to blog posts.

If `refinerycms-blog` is installed on your rails app, `refinerycms-page-images` will automatically detect it and perform the adequate initialization. PageImages are assigned to a polymorph "page" object, wich can be a `Refinery::Page` or a `Blog::Post`.

Thus, once installed, you can simply call a blog post's images the same way you'd call them for a page, like this

```erb
<% @blog_posts.each do |blog_post| %>
  <ul id='gallery'>
    <% blog_post.images.each do |image| %>
      <li>
        <%= link_to image_tag(image.thumbnail(geometry: "200x200#c").url),
                    image.thumbnail(geometry: "900x600").url %>
      </li>
   <% end %>
  </ul>
<% end %>
<%= render :partial => "/refinery/content_page" %>
```


## Screenshot

![Refinery CMS Page Images Screenshot](http://refinerycms.com/system/images/0000/1736/refinerycms-page-images.png)
