require "spec_helper"

describe "page images" do
  refinery_login_with :refinery_user

  let(:configure) {}
  let(:page_for_images) { FactoryGirl.create(:page) }
  let(:image) { FactoryGirl.create(:image) }
  let(:navigate_to_edit) { visit refinery.edit_admin_page_path(page_for_images) }
  let(:page_images_tab_id) { "#custom_#{::I18n.t(:'refinery.plugins.refinery_page_images.tab_name')}_tab" }

  let(:setup_and_visit) do
    configure
    page_for_images
    navigate_to_edit
  end

  # Regression test for #100 and #102
  it "can add a page image to the db", :js => true do

    image
    setup_and_visit

    page_for_images.images.count.should eq 0

    page.find("#{page_images_tab_id} a").click

    # Add the first Image
    click_link "Add Image"

    page.should have_selector 'iframe#dialog_iframe'
    page.within_frame('dialog_iframe') do
      find(:css, "#existing_image_area img#image_#{image.id}").click
      click_button ::I18n.t('button_text', :scope => 'refinery.admin.images.existing_image')
    end

    # image should be visable on the page
    page.should have_selector("#page_images li#image_#{image.id}")

    click_button "Save"

    # image should be in the db
    page_for_images.images.count.should eq 1

  end

  context "with images" do

    let(:page_for_images) { FactoryGirl.create(:page_with_image) }

    # Regression test for #100 and #102
    it "can remove a page image to the db", :js => true do

      setup_and_visit

      page_for_images.images.count.should eq 1

      page.find("#{page_images_tab_id} a").click

      page.should have_selector("#page_images li#image_#{page_for_images.images.first.id}")

      image_li_tag = page.find("#page_images li:first-child")
      image_li_tag.hover
      within(image_li_tag) { page.find('img:first-child').click }

      page.should_not have_selector("#page_images li#image_#{page_for_images.images.first.id}")

      click_button "Save"

      page_for_images.images.count.should eq 0

    end
  end

end

