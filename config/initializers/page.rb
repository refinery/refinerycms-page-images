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