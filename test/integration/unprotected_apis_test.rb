require "test_helper"

class UnprotectedApisTest < ActionDispatch::IntegrationTest
  test "user registration" do
    post "/api/register", params: { user: { email: "phb.aslan@gmail.com", password: "111111" } }
    assert_response :success
    assert_equal "User registered successfully", response.parsed_body["message"]
  end

  test "user login" do
    post "/api/login", params: { email: "phb.aslan@gmail.com", password: "bcb15f821479b4d5772bd0ca866c00ad5f926e3580720659cc80d39c9d09802a" }
    assert_response :success
  end
end
