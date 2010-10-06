require 'refinery'

module Refinery
  module PageImages
    class Engine < Rails::Engine
      initializer "static assets" do |app|
        app.middleware.insert_after ::ActionDispatch::Static, ::ActionDispatch::Static, "#{root}/public"
      end
      
      config.to_prepare do
        Page.module_eval do

          has_and_belongs_to_many :images
          accepts_nested_attributes_for :images, :allow_destroy => false

          def images_attributes=(data)
            self.images.clear
            self.images += (0..(data.length-1)).collect { |i|
              (Image.find(data[i.to_s]['id'].to_i) rescue nil)
            }.compact
          end
        end
      end
      
      config.after_initialize do

        Refinery::Pages::Tab.register do |tab|
          tab.name = "images"
          tab.partial = "/admin/pages/tabs/images"
        end
      end
    end
  end
end

