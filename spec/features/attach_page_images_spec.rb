require "spec_helper"

describe "attach page images", type: :feature do
  refinery_login

  # No-op block : use default configuration by default
  let(:configure) {}
  let(:create_page) { FactoryGirl.create(:page_with_page_part) }
  let(:navigate_to_edit)  { click_link "Edit this page" }
  let(:page_images_tab_id) { "#custom_#{::I18n.t(:'refinery.plugins.refinery_page_images.tab_name')}_tab"  }

  let(:setup_and_visit) do
    configure
    create_page
    visit refinery.admin_pages_path
    navigate_to_edit
  end

  it "shows images tab" do
    setup_and_visit
    within page_images_tab_id do
      expect(page).to have_content("Images")
    end
  end

  # This spec actually is broken in a way because Add Image link would
  # be visible to capybara even if we don't click on Images tab.
  it "shows add image link" do
    setup_and_visit
    within page_images_tab_id do
      click_link "Images"
    end

    expect(page).to have_content("Add Image")
  end

  context "with caption and WYSIWYG disabled" do
    let(:configure) do
      Refinery::PageImages.config.wysiwyg  = false
      Refinery::PageImages.config.captions = true
    end

    let(:create_page) { FactoryGirl.create(:page_with_image) }
    let(:navigate_to_edit) { page.find('a[tooltip="Edit this page"]').click }

    it "shows a plain textarea when editing caption", js: true do
      setup_and_visit
      page.find("#{page_images_tab_id} a").click
      image_li_tag = page.find("#page_images li:first-child")

      image_li_tag.hover
      within(image_li_tag) { page.find('img.caption').click }

      expect(page.find('.ui-dialog textarea')).to be_visible
    end
  end

end
