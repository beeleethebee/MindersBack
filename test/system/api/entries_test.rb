# frozen_string_literal: true

require 'application_system_test_case'

module Api
  class EntriesTest < ApplicationSystemTestCase
    setup do
      @api_entry = api_entries(:one)
    end

    test 'visiting the index' do
      visit api_entries_url
      assert_selector 'h1', text: 'Api/Entries'
    end

    test 'creating a Entry' do
      visit api_entries_url
      click_on 'New Api/Entry'

      click_on 'Create Entry'

      assert_text 'Entry was successfully created'
      click_on 'Back'
    end

    test 'updating a Entry' do
      visit api_entries_url
      click_on 'Edit', match: :first

      click_on 'Update Entry'

      assert_text 'Entry was successfully updated'
      click_on 'Back'
    end

    test 'destroying a Entry' do
      visit api_entries_url
      page.accept_confirm do
        click_on 'Destroy', match: :first
      end

      assert_text 'Entry was successfully destroyed'
    end
  end
end
