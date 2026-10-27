require "test_helper"

class BaseControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get base_index_url
    assert_response :success
  end
end
