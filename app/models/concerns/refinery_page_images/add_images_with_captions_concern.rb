require 'ostruct'

module RefineryPageImages
  module AddImagesWithCaptionsConcern
    extend ActiveSupport::Concern
    included do
      attr_accessor :images_with_captions
      prepend(InstanceMethods)
    end

    module InstanceMethods
      def images_with_captions
        @images_with_captions = image_pages.map do |ref|
          OpenStruct.new(
            {
              image: Refinery::Image.find(ref.image_id),
              caption: ref.caption || ''
            }
          )
        end
      end
    end
  end
end