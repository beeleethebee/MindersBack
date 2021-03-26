# frozen_string_literal: true

json.array! @entries, partial: 'api/entries/entry', as: :entry
