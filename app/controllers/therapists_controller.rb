# frozen_string_literal: true

#:nodoc:
class TherapistsController < ApplicationController
  before_action :authenticate_therapist!, except: :home

  def home; end

  def index
    @therapist = current_therapist
  end
end
