class AddTherapistIdToPatient < ActiveRecord::Migration[6.0]
  def change
    add_reference :patients, :therapist, foreign_key: true, null: true
  end
end
