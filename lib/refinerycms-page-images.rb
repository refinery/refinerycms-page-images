require 'refinery'

module Refinery
  module PageImages
    class Engine < Rails::Engine
      initializer "static assets" do |app|
        app.middleware.insert_after ::ActionDispatch::Static, ::ActionDispatch::Static, "#{root}/public"
      end

      config.to_prepare do
        Page.module_eval do
          has_many :image_pages
          has_many :images, :through => :image_pages, :order => 'position ASC'
          # accepts_nested_attributes_for MUST come before def images_attributes=
          # this is because images_attributes= overrides accepts_nested_attributes_for.
          accepts_nested_attributes_for :images, :allow_destroy => false

          attr_accessible :images_attributes

          def images_attributes=(data)
            ImagePage.delete_all(:page_id => self.id)

            (0..(data.length-1)).each do |i|
              unless (image_data = data[i.to_s]).nil? or image_data['id'].blank?
                image_page = self.image_pages.new(:image_id => image_data['id'].to_i, :position => i)
                # Add caption if supported
                if RefinerySetting.find_or_set(:page_images_captions, false)
                  image_page.caption = image_data['caption']
                end
                self.image_pages << image_page
              end
            end
          end

          def caption_for_image_index(index)
            self.image_pages[index].try(:caption).presence || ""
          end
        end
      end

      config.after_initialize do
        ::Refinery::Pages::Tab.register do |tab|
          tab.name = "images"
          tab.partial = "/admin/pages/tabs/images"
        end
        ::Refinery::Plugin.register do |plugin|
          plugin.name = "page_images"
          plugin.hide_from_menu = true
        end
      end
    end
  end
end

