class CreatePageImages < ActiveRecord::Migration

  def self.up
    create_table :image_pages, :id => false do |t|
      t.integer :image_id
      t.integer :page_id
      t.integer :position
    end

    add_index :image_pages, :image_id
    add_index :image_pages, :page_id
  end

  def self.down
    drop_table :image_pages
  end

end