# frozen_string_literal: true

require 'application_system_test_case'

class TherapistsTest < ApplicationSystemTestCase
  setup do
    @therapist = therapists(:one)
  end

  test 'visiting the index' do
    visit therapists_url
    assert_selector 'h1', text: 'Therapists'
  end

  test 'creating a Therapist' do
    visit therapists_url
    click_on 'New Therapist'

    fill_in 'Address', with: @therapist.address
    fill_in 'First name', with: @therapist.first_name
    fill_in 'Last name', with: @therapist.last_name
    click_on 'Create Therapist'

    assert_text 'Therapist was successfully created'
    click_on 'Back'
  end

  test 'updating a Therapist' do
    visit therapists_url
    click_on 'Edit', match: :first

    fill_in 'Address', with: @therapist.address
    fill_in 'First name', with: @therapist.first_name
    fill_in 'Last name', with: @therapist.last_name
    click_on 'Update Therapist'

    assert_text 'Therapist was successfully updated'
    click_on 'Back'
  end

  test 'destroying a Therapist' do
    visit therapists_url
    page.accept_confirm do
      click_on 'Destroy', match: :first
    end

    assert_text 'Therapist was successfully destroyed'
  end
end
