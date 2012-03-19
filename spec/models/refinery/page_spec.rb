require 'spec_helper'

module Refinery
  describe Page do
    it "can have images added" do
      page = Factory(:page)
      page.images.count.should eq(0)

      page.images << Factory(:image)
      page.images.count.should eq(1)
    end

    describe "#images_attributes=" do
      it "adds images" do
        page = Factory(:page)
        image = Factory(:image)

        page.images.count.should == 0
        page.update_attributes({:images_attributes => {"0" => {"id" => image.id}}})

        page.images.count.should == 1
      end

      it "deletes specific images" do
        page = Factory(:page)
        images = [Factory(:image), Factory(:image)]
        page.images = images

        page.update_attributes(:images_attributes => {
          "0" => {
            "id" => images.first.id.to_s,
            "image_page_id" => page.image_pages.first.id,
          },
        })

        page.images.should eq([images.first])
      end

      it "deletes all images" do
        page = Factory(:page)
        images = [Factory(:image), Factory(:image)]
        page.images = images

        page.update_attributes(:images_attributes => {"0" => {"id"=>""}})

        page.images.should be_empty
      end

      it "reorders images" do
        page = Factory(:page)
        images = [Factory(:image), Factory(:image)]
        page.images = images

        page.update_attributes(:images_attributes => {
          "0" => {
            "id" => images.second.id,
            "image_page_id" => page.image_pages.second.id,
          },
          "1" => {
            "id" => images.first.id,
            "image_page_id" => page.image_pages.first.id,
          },
        })

        page.images.should eq([images.second, images.first])
      end
    end
  end
end
