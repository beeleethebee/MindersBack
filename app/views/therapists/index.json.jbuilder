# frozen_string_literal: true

json.array! @therapists, partial: 'therapists/therapist', as: :therapist
