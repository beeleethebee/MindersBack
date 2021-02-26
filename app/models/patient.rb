class Patient < ApplicationRecord
  include DeviseTokenAuth::Concerns::User
  devise :database_authenticatable, :registerable, :recoverables

  belongs_to :therapist
end
