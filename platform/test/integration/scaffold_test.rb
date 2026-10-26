require "test_helper"

class ScaffoldTest < ActionDispatch::IntegrationTest
  test "public landing page clearly identifies the scaffold" do
    get root_url
    assert_response :success
    assert_select "h1", "VeyloraAccess"
    assert_match "not implemented yet", response.body
  end

  test "liveness endpoint responds" do
    get rails_health_check_url
    assert_response :success
  end

  test "planned enrollment endpoint is not exposed" do
    post "/api/v1/enrollments", params: { token: "invalid" }
    assert_response :not_found
  end
end
