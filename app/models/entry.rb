# frozen_string_literal: true

class Entry < ApplicationRecord
  belongs_to :patient
  validates_presence_of :context, :time, :location
end
