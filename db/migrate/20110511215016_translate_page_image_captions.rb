class TranslatePageImageCaptions < ActiveRecord::Migration
  def self.up
    add_column ::ImagePage.table_name, :id, :primary_key
    
    ::ImagePage.reset_column_information
    unless defined?(::ImagePage::Translation) && ::ImagePage::Translation.table_exists?
      ::ImagePage.create_translation_table!({
        :caption => :string
      }, {
        :migrate_data => true
      })
    end
  end

  def self.down
    ::ImagePage.reset_column_information

    ::ImagePage.drop_translation_table! :migrate_data => true
    
    remove_column ::ImagePage.table_name, :id
  end
end
