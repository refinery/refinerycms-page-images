class AddPageTypeToImagePages < ActiveRecord::Migration
  def self.up
    add_column ::ImagePage.table_name, :page_type, :string
  end

  def self.down
    remove_column ::ImagePage.table_name, :page_type
  end
end
