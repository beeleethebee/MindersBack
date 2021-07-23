# frozen_string_literal: true

class Entry < ApplicationRecord
  belongs_to :patient
  has_many :entry_categories, dependent: :destroy
  has_many :categories, through: :entry_categories
  validates_presence_of :context, :time, :location
end
