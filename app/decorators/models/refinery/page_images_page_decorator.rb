require 'ostruct'

module RefineryPageImagesAddImagesWithCaptions
  def self.prepended(base)
    base.attr_accessor :images_with_captions
  end

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

Refinery::Page.prepend(RefineryPageImagesAddImagesWithCaptions) rescue NameError