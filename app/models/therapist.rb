# frozen_string_literal: true

class Therapist < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable

  has_many :patients, dependent: :nullify
  has_many :consultations, dependent: :destroy
end
