# frozen_string_literal: true

class Patient < ActiveRecord::Base
  extend Devise::Models
  devise :database_authenticatable, :registerable,
         :recoverable, :validatable
  include DeviseTokenAuth::Concerns::User

  has_many :entries

  validates_presence_of :last_name, :first_name
end
