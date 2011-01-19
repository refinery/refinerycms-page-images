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

          def images_attributes=(values)
            values.reject!{|i, data| data['id'].blank?}
            self.images.each do |image|
              unless values.any? {|k, vals| vals['id'].to_s == image.id.to_s}
                values[values.length.to_s] = {
                  :id => image.id,
                  :_destroy => true
                }
              end
            end
            raise values.inspect
            assign_nested_attributes_for_collection_association(:images, values)
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

