require "spec_helper"

describe "attach page images" do
  refinery_login_with :refinery_user

  before(:each) do
    FactoryGirl.create(:page)

    visit refinery.admin_pages_path

    click_link "Edit this page"
  end

  it "shows images tab" do
    within "#custom_#{::I18n.t(:'refinery.plugins.refinery_page_images.tab_name')}_tab" do
      page.should have_content("Images")
    end
  end

  # This spec actually is broken in a way because Add Image link would
  # be visible to capybara even if we don't click on Images tab.
  it "shows add image link" do
    within "#custom_#{::I18n.t(:'refinery.plugins.refinery_page_images.tab_name')}_tab" do
      click_link "Images"
    end

    page.should have_content("Add Image")
  end
end
