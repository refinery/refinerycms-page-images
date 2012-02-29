FactoryGirl.define do
  factory :page_with_image, :parent => :page do
    after_create { |p| p.images << Factory(:image) }
  end

  factory :blog_post_with_image, :parent => :blog_post do
    after_create { |b| b.images << Factory(:image) }
  end if defined? Refinery::Blog::Post
end
