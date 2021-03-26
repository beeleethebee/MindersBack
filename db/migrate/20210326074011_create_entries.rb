# frozen_string_literal: true

class CreateEntries < ActiveRecord::Migration[6.0] # rubocop:todo Style/Documentation
  def change
    create_table :entries do |t|
      t.string :location
      t.string :context
      t.datetime :time
      t.references :patient, null: false, foreign_key: true

      t.timestamps
    end
  end
end
