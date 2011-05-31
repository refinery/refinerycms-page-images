require 'spec_helper'

Dir[File.expand_path('../support/factories.rb', __FILE__)].each {|f| require f}

describe BlogPost do
  it "should not have images" do
    blog = Factory(:blog_post)
    blog.images.count.should == 0
  end
  
  it "should have images" do
    blog = Factory(:blog_post_with_image)
    blog.images.count.should == 1
  end
end if defined?(BlogPost)
