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
        expect(page.images_with_captions.count).to eq(0)

        page.image_pages.create(image: FactoryGirl.build(:image))
        expect(page.images_with_captions.first[:image]).to be_a(Refinery::Image)
        expect(page.images_with_captions.first[:caption]).to be_a(String)
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

          expect(page.images).to eq([images.first])
        end

        it "deletes all images" do
          page.update_attributes(:images_attributes => {"0" => {"id"=>""}})

          expect(page.images).to be_empty
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

          expect(page.images).to eq([images.second, images.first])
        end
      end
    end
  end
end
