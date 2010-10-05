class CreatePageImages < ActiveRecord::Migration

  def self.up
    create_table :images_pages, :id => false do |t|
      t.integer :image_id
      t.integer :page_id
    end

    add_index :images_pages, :image_id
    add_index :images_pages, :page_id
  end

  def self.down
    drop_table :images_pages
  end

end