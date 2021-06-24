class RenameSessionToConsultation < ActiveRecord::Migration[6.0]
  def change
    rename_table :sessions, :consultations
  end
end
