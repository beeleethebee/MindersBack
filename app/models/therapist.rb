# frozen_string_literal: true

class Therapist < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable

  validates_presence_of :email, :last_name
  has_many :patients, dependent: :nullify
end
