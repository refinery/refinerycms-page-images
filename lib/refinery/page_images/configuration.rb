module Refinery
  module PageImages
    include ActiveSupport::Configurable

    config_accessor :captions
    config_accessor :attach_to
    config_accessor :tab_locations

    self.captions = false
    self.attach_to = [
    	{:engine => Refinery::Page, 		:tab => Refinery::Page},
    	{:engine => Refinery::Blog::Post, 	:tab => Refinery::Blog}
    ]
  end
end
