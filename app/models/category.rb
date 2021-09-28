# frozen_string_literal: true

class Category < ApplicationRecord
  belongs_to :patient, optional: true
  has_many :entry_categories, dependent: :destroy
  has_many :categories, through: :entry_categories

  validates_presence_of :name
  validates_uniqueness_of :name, scope: :patient_id
end
