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

        page_image_to_keep = page.image_pages.find do |image_page|
          image_page.image_id == images.first.id
        end
        page.update_attributes(:images_attributes => {
          "0" => {
            "id" => page_image_to_keep.image_id.to_s,
            "image_page_id" => page_image_to_keep.id
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

        first_page_image = page.image_pages.find do |image_page|
          image_page.image_id == images.first.id
        end
        second_page_image = page.image_pages.find do |image_page|
          image_page.image_id == images.second.id
        end

        page.update_attributes(:images_attributes => {
          "0" => {
            "id" => second_page_image.image_id,
            "image_page_id" => second_page_image.id,
          },
          "1" => {
            "id" => first_page_image.image_id,
            "image_page_id" => first_page_image.id,
          },
        })

        page.images.should eq([images.second, images.first])
      end
    end
  end
end
