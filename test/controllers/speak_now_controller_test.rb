require 'test_helper'

class SpeakNowControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get speak_now_index_url
    assert_response :success
  end

end
