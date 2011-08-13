class CreatePageImages < ActiveRecord::Migration
  def change
    create_table Refinery::ImagePage.table_name, :id => false do |t|
      t.integer :image_id
      t.integer :page_id
      t.integer :position
    end

    add_index Refinery::ImagePage.table_name, :image_id
    add_index Refinery::ImagePage.table_name, :page_id
  end
end
