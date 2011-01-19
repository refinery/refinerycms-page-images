class AddCaptionToImagePages < ActiveRecord::Migration
  def self.up
    add_column :image_pages, :caption, :text
  end

  def self.down
    remove_column :image_pages, :caption
  end
end
