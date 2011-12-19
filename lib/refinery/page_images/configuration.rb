module Refinery
  module PageImages
    include ActiveSupport::Configurable

    config_accessor :captions

    self.captions = false
  end
end
