class AddPositivityToStatus < ActiveRecord::Migration[6.0]
  def change
    add_column :statuses, :positivity, :integer, default: 5
  end
end
