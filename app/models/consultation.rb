# frozen_string_literal: true

class Consultation < ApplicationRecord
  belongs_to :therapist
  belongs_to :patient
end
