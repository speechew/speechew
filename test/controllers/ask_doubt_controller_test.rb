require 'test_helper'

class AskDoubtControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get ask_doubt_index_url
    assert_response :success
  end

end
