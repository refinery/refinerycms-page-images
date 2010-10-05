class CreatePageImages < ActiveRecord::Migration

  def self.up
    create_table :page_images do |t|
      t.string :title
      t.integer :position

      t.timestamps
    end

    add_index :page_images, :id

  end

  def self.down

    drop_table :page_images
  end

end
