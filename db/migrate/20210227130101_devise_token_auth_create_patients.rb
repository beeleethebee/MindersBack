class DeviseTokenAuthCreatePatients < ActiveRecord::Migration[6.0]
  def change

    create_table(:patients) do |t|
      ## Required
      t.string :provider, :null => false, :default => "email"
      t.string :uid, :null => false, :default => ""

      ## Database authenticatable
      t.string :encrypted_password, :null => false, :default => ""

      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at
      t.boolean  :allow_password_change, :default => false

      ## Rememberable
      t.datetime :remember_created_at

      ## Confirmable
      t.string   :confirmation_token
      t.datetime :confirmed_at
      t.datetime :confirmation_sent_at
      t.string   :unconfirmed_email # Only if using reconfirmable

      ## User Info
      t.string :first_name
      t.string :last_name
      t.string :email

      ## Tokens
      t.json :tokens

      t.timestamps
    end

    add_index :patients, :email,                unique: true
    add_index :patients, [:uid, :provider],     unique: true
    add_index :patients, :reset_password_token, unique: true
    add_index :patients, :confirmation_token,   unique: true
  end
end
