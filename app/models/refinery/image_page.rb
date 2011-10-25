module Refinery
  class ImagePage < ActiveRecord::Base

    belongs_to :image
    belongs_to :page, :polymorphic => true

    translates :caption if self.respond_to?(:translates)

    attr_accessible :image_id, :position, :locale
    self.class.translation_class.send :attr_accessible, :locale

  end
end
