class Therapist < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable
end
