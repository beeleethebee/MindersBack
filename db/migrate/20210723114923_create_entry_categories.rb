class CreateEntryCategories < ActiveRecord::Migration[6.0]
  def change
    create_table :entry_categories do |t|
      t.references :entry, null: false, foreign_key: true
      t.references :category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
