require 'spec_helper'

module Refinery
  module Blog
    describe Post, type: :model do
      it "should not have images" do
        blog = FactoryGirl.create(:blog_post)
        blog.images.count.should == 0
      end

      it "should have images" do
        blog = FactoryGirl.create(:blog_post_with_image)
        blog.images.count.should == 1
      end
    end
  end
end if defined?(Refinery::Blog::Post)
