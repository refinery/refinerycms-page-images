module Refinery
  module PageImages
    include ActiveSupport::Configurable

    config_accessor :captions, :enable_for

    self.captions = false
    self.enable_for = [
      { :model => 'Refinery::Page', :tab => 'Refinery::Pages::Tab' },
    ]

    if defined?(Refinery::Blog)
      self.enable_for << { :model => 'Refinery::Blog::Post', :tab => 'Refinery::Blog::Tab' }
    end

    config.instance_eval do
      def enabled_tabs
        extract_enabled_option(:tab)
      end

      def enabled_models
        extract_enabled_option(:model)
      end

      private
      def extract_enabled_option(key)
        enable_for.map { |enable_for| enable_for[key] }.compact
      end
    end

  end
end
