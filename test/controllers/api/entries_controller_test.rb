# frozen_string_literal: true

require 'test_helper'

module Api
  class EntriesControllerTest < ActionDispatch::IntegrationTest
    setup do
      @api_entry = api_entries(:one)
    end

    test 'should get index' do
      get api_entries_url
      assert_response :success
    end

    test 'should get new' do
      get new_api_entry_url
      assert_response :success
    end

    test 'should create api_entry' do
      assert_difference('Api::Entry.count') do
        post api_entries_url, params: { api_entry: {} }
      end

      assert_redirected_to api_entry_url(Api::Entry.last)
    end

    test 'should show api_entry' do
      get api_entry_url(@api_entry)
      assert_response :success
    end

    test 'should get edit' do
      get edit_api_entry_url(@api_entry)
      assert_response :success
    end

    test 'should update api_entry' do
      patch api_entry_url(@api_entry), params: { api_entry: {} }
      assert_redirected_to api_entry_url(@api_entry)
    end

    test 'should destroy api_entry' do
      assert_difference('Api::Entry.count', -1) do
        delete api_entry_url(@api_entry)
      end

      assert_redirected_to api_entries_url
    end
  end
end
