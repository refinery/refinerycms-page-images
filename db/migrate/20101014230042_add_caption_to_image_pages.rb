class AddCaptionToImagePages < ActiveRecord::Migration
  def change
    add_column Refinery::ImagePage.table_name, :caption, :text
  end
end
