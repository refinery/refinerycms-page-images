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
        if PageImages.config.enable_for.include?('Refinery::Pages')
          Refinery::Pages::Tab.register { |tab| register tab }
       end

        if PageImages.config.enable_for.include?('Refinery::Blog') && defined?(Refinery::Blog::Tab)
          Refinery::Blog::Tab.register { |tab| register tab }
        end

        Refinery.register_engine Refinery::PageImages
      end
    end
  end
end
