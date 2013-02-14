module Refinery
  module PageImages
    include ActiveSupport::Configurable

    config_accessor :captions, :enable_for

    self.captions = false
    self.enable_for = ['Refinery::Pages', 'Refinery::Blog']
  end
end
