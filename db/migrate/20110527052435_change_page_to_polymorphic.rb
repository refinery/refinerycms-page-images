class ChangePageToPolymorphic < ActiveRecord::Migration
  def change
    add_column Refinery::ImagePage.table_name, :page_type, :string, :default => "page"
  end
end
