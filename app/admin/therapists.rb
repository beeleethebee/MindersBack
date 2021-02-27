# frozen_string_literal: true

ActiveAdmin.register Therapist do
  permit_params :email, :password, :first_name, :last_name

  index do
    selectable_column
    id_column
    column :email
    column(:name) { |therapist| "#{therapist.last_name} #{therapist.first_name}" }
    column :current_sign_in_at
    column :sign_in_count
    column :created_at
    actions
  end

  filter :email
  filter :current_sign_in_at
  filter :sign_in_count
  filter :created_at

  form do |f|
    f.inputs do
      f.input :email
      f.input :first_name
      f.input :last_name
      f.input :password
    end
    f.actions
  end
end
