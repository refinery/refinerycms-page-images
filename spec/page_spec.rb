require 'spec_helper'

Dir[File.expand_path('../support/factories.rb', __FILE__)].each {|f| require f}


describe Page do
  it "should have an image" do
    p = Factory(:page_with_image)
    p.images.count.should eql(1) 
  end
  
  it "should accept images_attributes=" do
    page = Factory(:page)
    image = Factory(:image)
    
    page.images.count.should eql(0)
    page.update_attributes({:images_attributes => {"0" => {"id" => image.id}}})
    
    page.images.count.should eql(1)
  end
  
end