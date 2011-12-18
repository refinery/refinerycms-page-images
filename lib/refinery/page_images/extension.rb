module Refinery
  module PageImages
    module Extension
      def self.included(base)
        base.extend(ClassMethods)
      end

      module ClassMethods
        def has_many_page_images
          has_many :image_pages, :as => :page, :order => 'position ASC'
          has_many :images, :through => :image_pages, :order => 'position ASC'
          # accepts_nested_attributes_for MUST come before def images_attributes=
          # this is because images_attributes= overrides accepts_nested_attributes_for.

          accepts_nested_attributes_for :images, :allow_destroy => false
          module_eval do ## need to do it this way because of the way accepts_nested_attributes_for deletes an already defined images_attributes
            def images_attributes=(data)
              ids_to_delete = data.map{|i, d| d['image_page_id']}.compact
              self.image_pages.each do |image_page|
                if ids_to_delete.index(image_page.id.to_s).nil?
                  # Image has been removed, we must delete it
                  self.image_pages.delete(image_page)
                  image_page.destroy
                end
              end

              (0..(data.length-1)).each do |i|
                unless (image_data = data[i.to_s]).nil? or image_data['id'].blank?
                  image_page = if image_data['image_page_id'].present?
                    self.image_pages.find(image_data['image_page_id'])
                  else
                    self.image_pages.new(:image_id => image_data['id'].to_i)
                  end
                  image_page.position = i
                  # Add caption if supported
                  image_page.caption = image_data['caption'] if Refinery::PageImages.config.captions

                  self.image_pages << image_page if image_data['image_page_id'].blank?
                  image_page.save
                end
              end
            end
          end

          include Refinery::PageImages::Extension::InstanceMethods

          # this wasn't working for me so I've commented it out for now
          # if ActiveModel::MassAssignmentSecurity::WhiteList === active_authorizer
          #   attr_accessible :images_attributes
          # else
          #   # to prevent a future call to attr_accessible
          #   self._accessible_attributes = accessible_attributes + [:images_attributes]
          # end
          attr_accessible :images_attributes
        end
      end

      module InstanceMethods

        def caption_for_image_index(index)
          self.image_pages[index].try(:caption).presence || ""
        end

        def image_page_id_for_image_index(index)
          self.image_pages[index].try(:id)
        end
      end
    end
  end
end

ActiveRecord::Base.send(:include, Refinery::PageImages::Extension)