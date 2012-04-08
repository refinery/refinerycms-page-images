module Refinery
  module PageImages
    class Engine < Rails::Engine
      include Refinery::Engine

      isolate_namespace Refinery

      engine_name :refinery_page_images

      def self.register(tab)
        tab.name = "images"
        tab.partial = "/refinery/admin/pages/tabs/images"
      end

      initializer "register refinery_page_images plugin" do
        Refinery::Plugin.register do |plugin|
          plugin.name = "page_images"
          plugin.hide_from_menu = true
        end
      end

      config.to_prepare do
        Refinery::PageImages.attach_to.each do |a|
          e = a[:engine]
          e.constantize.send(:has_many_page_images) if defined?(e.constantize)
        end
        Refinery::Image.module_eval do
          has_many :image_pages, :dependent => :destroy
        end
      end

      config.after_initialize do
        Refinery::PageImages.attach_to.each do |a|
          t = a[:tab]
          if defined?(t.constantize)
            t.constantize.register do |tab|
              register tab
            end
          end
        end
        
        Refinery.register_engine(Refinery::PageImages)
      end
    end
  end
end