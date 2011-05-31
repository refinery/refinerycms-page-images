class ChangePageToPolymorphic < ActiveRecord::Migration
  def self.up
    change_table :image_pages do |t|
      t.string :page_type, :default => "page"
    end
  end

  def self.down
    remove_column :image_pages, :page_type
  end
end
