require 'spec_helper'

module Refinery
  describe Page, type: :model do
    let!(:page) { FactoryGirl.create :page }
    it "can have images added" do
      expect {
        page.image_pages.create(image: FactoryGirl.build(:image))
      }.to change{page.images.count}.from(0).to(1)
    end

    describe '#images_with_captions' do
      it 'returns an images_with_captions collection' do
        expect {
          page.image_pages.create(image: FactoryGirl.build(:image))
        }.to change{page.images_with_captions.count}.from(0).to(1)
      end

      it 'returns an image and a caption' do
        page.images_with_captions.count.should eq(0)

        page.image_pages.create(image: FactoryGirl.build(:image))
        page.images_with_captions.first[:image].should be_a(Refinery::Image)
        page.images_with_captions.first[:caption].should be_a(String)
      end

    end

    describe '#images_with_captions' do
      it 'returns an images_with_captions collection' do
        page = FactoryGirl.create(:page)
        page.images_with_captions.count.should eq(0)

        page.images << FactoryGirl.create(:image)
        page.images_with_captions.count.should eq(1)
      end

      it 'returns an image and a caption' do
        page = FactoryGirl.create(:page)
        page.images_with_captions.count.should eq(0)

        page.images << FactoryGirl.create(:image)
        page.images_with_captions.first[:image].should be_a(Refinery::Image)
        page.images_with_captions.first[:caption].should be_a(String)
      end

    end

    describe "#images_attributes=" do
      it "adds images" do
        image = FactoryGirl.create(:image)

        expect {
          page.update_attributes({:images_attributes => {"0" => {"id" => image.id}}})
        }.to change { page.images.count }.from(0).to(1)
      end

      context 'with images' do
        let!(:images) { [FactoryGirl.create(:image), FactoryGirl.create(:image)] }
        before do
          images.each do |image|
            page.image_pages.create(image: image)
          end
        end
        it "deletes specific images" do
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
          page.update_attributes(:images_attributes => {"0" => {"id"=>""}})

          page.images.should be_empty
        end

        it "reorders images" do
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
end
