# frozen_string_literal: true

class Patient < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :validatable
  extend Devise::Models
  include DeviseTokenAuth::Concerns::User

  has_many :entries, dependent: :destroy
  has_many :consultations, dependent: :destroy
  belongs_to :therapist, optional: true
  has_many :statuses

  validates_presence_of :last_name, :first_name

  def to_s
    "#{first_name} #{last_name}"
  end
end
