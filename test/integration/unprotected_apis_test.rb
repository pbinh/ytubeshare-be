require "test_helper"

class UnprotectedApisTest < ActionDispatch::IntegrationTest
  EMAIL = "phb.aslan@gmail.com"
  PASSWORD = "111111"
  HASHED_PASSWORD = "bcb15f821479b4d5772bd0ca866c00ad5f926e3580720659cc80d39c9d09802a"

  test "user registration" do
    post "/api/register", params: { user: { email: EMAIL, password: PASSWORD } }
    assert_response :success
    assert_equal "User registered successfully", response.parsed_body["message"]
  end

  test "user login" do
    user = users(:one)
    post "/api/login", params: { email: EMAIL, password: HASHED_PASSWORD }
    assert_response :success
  end
end
