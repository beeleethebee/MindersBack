# frozen_string_literal: true

json.array! @categories, partial: 'api/categories/category', as: :category
