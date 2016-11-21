require 'spec_helper'

module Refinery
  describe ImagePage, type: :model do
    let!(:image_page) { FactoryGirl.create(:image_page) }

    describe "touching" do
      it "updates a page" do
        image_page.page.update_column(:updated_at, 1.day.ago)
        image_page.touch
        expect(image_page.page.reload.updated_at).to be_within(3.seconds).of(Time.current)
      end
    end
  end
end
