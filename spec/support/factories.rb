require 'factory_girl'

Factory.define :page do |p|
  p.title 'Whatnot'
end

Factory.define :image do |i|
  i.image File.new(File.expand_path('../../uploads/beach.jpeg', __FILE__))
end

Factory.define :page_with_image, :parent => :page do |page|
  page.after_create { |p| p.images << Factory(:image) }
end

Factory.define :blog_post do |b|
  b.title "This is an awesome blog post"
  b.body "Whatnot"
end

Factory.define :blog_post_with_image, :parent => :blog_post do |blog|
  blog.after_create { |b| b.images << Factory(:image) }
end

