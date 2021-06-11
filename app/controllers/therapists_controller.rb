# frozen_string_literal: true

#:nodoc:
class TherapistsController < ApplicationController
  before_action :authenticate_therapist!, except: :home
  before_action :set_therapist, except: :home

  def home; end

  def index
    @patients = @therapist.patients.includes(:statuses)
  end

  private

  def set_therapist
    @therapist = current_therapist
  end
end
