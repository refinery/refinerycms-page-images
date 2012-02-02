module Refinery
  module PageImages
    class Engine < Rails::Engine
      isolate_namespace Refinery
      engine_name :refinery_page_images

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

        ::Refinery::Core.configure do |core|
          core.register_stylesheet 'refinery/page-image-picker.css'
          core.register_javascript 'refinery/page-image-picker.js'
        end

        ::Refinery::Plugin.register do |plugin|
          plugin.name = "page_images"
          plugin.hide_from_menu = true
        end

        Refinery.register_engine(Refinery::PageImages)
      end
    end
  end
end
