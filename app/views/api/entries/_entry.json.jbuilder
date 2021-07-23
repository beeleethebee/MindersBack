# frozen_string_literal: true

json.extract! entry, :id, :context, :location, :time, :patient_id, :created_at, :updated_at
json.categories do
  json.array! entry.categories, partial: 'api/categories/category', as: :category
end
