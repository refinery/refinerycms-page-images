require 'ostruct'

Refinery::Page.class_eval do
  attr_accessor :images_with_captions

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