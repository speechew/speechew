require 'test_helper'

class GiveFeedbackControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get give_feedback_index_url
    assert_response :success
  end

end
