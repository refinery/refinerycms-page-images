module Refinery
  module PageImages
    class Engine < Rails::Engine
      isolate_namespace Refinery

      def self.register(tab)
        tab.name = "images"
        tab.partial = "/refinery/admin/pages/tabs/images"
      end

      config.to_prepare do
        require 'refinerycms-pages'
        ::Refinery::Page.send :has_many_page_images
        ::Refinery::Blog::Post.send :has_many_page_images if defined?(::Refinery::Blog)
        ::Refinery::Image.module_eval do
          has_many :image_pages, :dependent => :destroy
        end
      end

      config.after_initialize do
        ::Refinery::Pages::Tab.register do |tab|
          register tab
        end

        if defined?(::Refinery::Blog::Tab)
          ::Refinery::Blog::Tab.register do |tab|
            register tab
          end
        end

        ::Refinery::Plugin.register do |plugin|
          plugin.name = "page_images"
          plugin.hide_from_menu = true
        end
      end
    end
  end
end
