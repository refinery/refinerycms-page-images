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
    allow(Refinery::PageImages.config).to receive(:enable_for).and_return(enable_for_config)
  end

  def enable_for_config
    [{ :model => 'Refinery::PageImages::EnableForMock::Model',
       :tab => 'Refinery::PageImages::EnableForMock::Tab' }]
  end

  describe "attach initializer" do
    it "calls attach on all configured model" do
      allow(Refinery::PageImages.config).to receive(:enable_for).and_return(enable_for_config)

      expect(Refinery::PageImages::EnableForMock::Model).to receive(:has_many_page_images).once
      expect(Refinery::Page).not_to receive(:has_many_page_images)
      Rails.application.reloader.prepare!
    end
  end

  describe "attach_initialize_tabs!" do
    it "registers tabs for all configured engine" do
      expect(Refinery::PageImages::EnableForMock::Tab).to receive(:register).once
      expect(Refinery::Pages::Tab).not_to receive(:register)
      Refinery::PageImages::Engine.initialize_tabs!
    end
  end

end
