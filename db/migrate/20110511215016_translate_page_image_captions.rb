class TranslatePageImageCaptions < ActiveRecord::Migration[4.2]
  def change
    create_table :refinery_image_page_translations do |t|

      # Translated attribute(s)
      t.text :caption

      t.string  :locale, null: false
      t.integer :refinery_image_page_id, null: false

      t.timestamps null: false
    end

    add_index :refinery_image_page_translations, :locale, name: :index_refinery_image_page_translations_on_locale
    add_index :refinery_image_page_translations, [:refinery_image_page_id, :locale], name: :index_114aab0bbdedc79d0ec4f4b, unique: true
  end
end
