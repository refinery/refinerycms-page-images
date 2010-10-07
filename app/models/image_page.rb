class ImagePage < ActiveRecord::Base
  
  belongs_to :image
  belongs_to :page

  before_save do |image_page|
    image_page.position = (ImagePage.maximum(:position) || -1) + 1
  end

end