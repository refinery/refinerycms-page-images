module Refinery
  module PageImages
    include ActiveSupport::Configurable

    config_accessor :captions
    config_accessor :attach_to

    self.captions = false
    self.attach_to = [
    	{:engine => 'Refinery::Page', 			:tab => 'Refinery::Pages::Tab'},
    	{:engine => 'Refinery::Blog::Post', 	:tab => 'Refinery::Blog::Tab'}
    ]
  end
end
