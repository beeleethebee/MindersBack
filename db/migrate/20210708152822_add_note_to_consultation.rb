class AddNoteToConsultation < ActiveRecord::Migration[6.0]
  def change
    add_column :consultations, :note, :text
  end
end
