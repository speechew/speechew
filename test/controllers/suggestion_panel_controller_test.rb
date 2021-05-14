# frozen_string_literal: true

require 'test_helper'

class SuggestionPanelControllerTest < ActionDispatch::IntegrationTest
  test 'should get index' do
    get suggestion_panel_index_url
    assert_response :success
  end
end
