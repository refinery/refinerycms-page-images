class TranslatePageImageCaptions < ActiveRecord::Migration
  def up
    add_column Refinery::ImagePage.table_name, :id, :primary_key

    Refinery::ImagePage.reset_column_information
    unless defined?(Refinery::ImagePage::Translation) && Refinery::ImagePage::Translation.table_exists?
      Refinery::ImagePage.create_translation_table!({
        :caption => :text
      }, {
        :migrate_data => true
      })
    end
  end

  def down
    Refinery::ImagePage.reset_column_information

    Refinery::ImagePage.drop_translation_table! :migrate_data => true

    remove_column Refinery::ImagePage.table_name, :id
  end
end
