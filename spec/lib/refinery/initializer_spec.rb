require 'spec_helper'

describe Refinery::PageImages::Engine do
  before(:all) do
    class Refinery::PageImages::EnableForMock
      class Model; end
      class Tab; end
    end
  end

  after(:all) do
    Refinery::PageImages.instance_eval { remove_const(:EnableForMock) }
  end

  before(:each) do
    Refinery::PageImages.config.stub(:enable_for).and_return(enable_for_config)
  end

  def enable_for_config
    [{ :model => 'Refinery::PageImages::EnableForMock::Model',
       :tab => 'Refinery::PageImages::EnableForMock::Tab' }]
  end

  describe "attach initializer" do
    it "calls attach on all configured model" do
      Refinery::PageImages.config.stub(:enable_for).and_return(enable_for_config)

      Refinery::PageImages::EnableForMock::Model.should_receive(:has_many_page_images).once
      Refinery::Page.should_not_receive(:has_many_page_images)
      attach_initializer = Refinery::PageImages::Engine.initializers.find do |initializer|
        initializer.name == "refinery.page_images.attach"
      end
      attach_initializer.run(Rails.application)
    end
  end

  describe "attach_initialize_tabs!" do
    it "registers tabs for all configured engine" do
      Refinery::PageImages::EnableForMock::Tab.should_receive(:register).once
      Refinery::Pages::Tab.should_not_receive(:register)
      Refinery::PageImages::Engine.initialize_tabs!
    end
  end

end
