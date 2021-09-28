# frozen_string_literal: true

class Status < ApplicationRecord
  belongs_to :patient
  validate :validate_positivity, :validate_title

  def to_s
    title
  end

  private

  def validate_title
    return if Global::STATUS.include? title

    errors.add(:title, "Doit avoir une valeur existante (#{Global::STATUS.join(', ')})")
  end

  def validate_positivity
    return unless positivity.negative? || positivity > 10

    errors.add(:positivity, 'Doit être compris entre 0 et 10')
  end
end
