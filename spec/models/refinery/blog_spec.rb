require 'spec_helper'

module Refinery
  describe BlogPost do
    it "should not have images" do
      blog = Factory(:blog_post)
      blog.images.count.should == 0
    end

    it "should have images" do
      blog = Factory(:blog_post_with_image)
      blog.images.count.should == 1
    end
  end 
end if defined?(Refinery::Blog::Post)
