require 'spec_helper'

module Refinery
  describe Page do
    it "should have an image" do
      p = Factory(:page_with_image)
      p.images.count.should == 1
    end

    it "should accept images_attributes=" do
      page = Factory(:page)
      image = Factory(:image)

      page.images.count.should == 0
      page.update_attributes({:images_attributes => {"0" => {"id" => image.id}}})

      page.images.count.should == 1
    end
  end
end
