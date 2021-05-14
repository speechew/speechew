# frozen_string_literal: true

require 'test_helper'

class UserGuidesControllerTest < ActionDispatch::IntegrationTest
  test 'should get index' do
    get user_guides_index_url
    assert_response :success
  end
end
