class ImagePage < ActiveRecord::Base
  
  belongs_to :image
  belongs_to :page
  
  translates :caption if self.respond_to?(:translates)

end