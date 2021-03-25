# frozen_string_literal: true

class Patient < ActiveRecord::Base
  extend Devise::Models
  devise :database_authenticatable, :registerable,
         :recoverable, :validatable
  include DeviseTokenAuth::Concerns::User
end
