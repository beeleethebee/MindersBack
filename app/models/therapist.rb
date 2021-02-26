# frozen_string_literal: true

class Therapist < ApplicationRecord
  include DeviseTokenAuth::Concerns::User
  devise :database_authenticatable, :registerable, :recoverables

  has_many :patients
end
