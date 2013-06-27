FactoryGirl.define do
  factory :page_with_image, :parent => :page do
    after(:create) { |p| p.images << FactoryGirl.create(:image) }
  end

  factory :blog_post_with_image, :parent => :blog_post do
    after(:create) { |b| b.images << FactoryGirl.create(:image) }
  end if defined? Refinery::Blog::Post
end
