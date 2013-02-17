require 'refinery/page_images/configuration'

module Refinery
  module PageImages
    class Engine < Rails::Engine
      include Refinery::Engine

      isolate_namespace Refinery

      engine_name :refinery_page_images

      def self.register(tab)
        tab.name = ::I18n.t(:'refinery.plugins.refinery_page_images.tab_name')
        tab.partial = "/refinery/admin/pages/tabs/images"
      end

      def self.initialize_tabs!
        PageImages.config.enabled_tabs.each do |tab_class_name|
          unless (tab_class = tab_class_name.safe_constantize)
            Rails.logger.warn "PageImages is unable to find tab class: #{tab_class_name}"
            next
          end
          tab_class.register { |tab| register tab }
        end
      end

      initializer "register refinery_page_images plugin" do
        Refinery::Plugin.register do |plugin|
          plugin.name = "page_images"
          plugin.hide_from_menu = true
        end
      end

      initializer "refinery.page_images.attach" do
        ActiveSupport.on_load(:active_record) do
          Refinery::PageImages.attach!
        end
      end

      config.after_initialize do
        initialize_tabs!
        Refinery.register_engine Refinery::PageImages
      end
    end
  end
end
