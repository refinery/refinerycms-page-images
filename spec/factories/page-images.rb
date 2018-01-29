FactoryBot.define do
  factory :page_with_image, :parent => :page_with_page_part do
    after(:create) { |p| p.image_pages.create(image: FactoryBot.create(:image)) }
  end

  factory :blog_post_with_image, :parent => :blog_post do
    after(:create) { |b| b.image_pages.create(image: FactoryBot.create(:image)) }
  end if defined? Refinery::Blog::Post

  factory :image_page, class: Refinery::ImagePage do
    image
    page
  end
end
