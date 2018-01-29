require 'spec_helper'

module Refinery
  describe ImagePage, type: :model do
    let!(:image_page) { FactoryBot.create(:image_page) }

    describe "touching" do
      let(:original_updated_at) { 1.day.ago }
      let(:page) { image_page.page }

      before { page.update_column(:updated_at, original_updated_at) }

      it "updates a page" do
        expect { image_page.touch }.to change { page.reload.updated_at }
                                   .to be_within(3.seconds).of(Time.current)
      end
    end
  end
end
