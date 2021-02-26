# frozen_string_literal: true

json.extract! therapist, :id, :first_name, :last_name, :address, :created_at, :updated_at
json.url therapist_url(therapist, format: :json)
