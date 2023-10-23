require "test_helper"

class UnprotectedApisTest < ActionDispatch::IntegrationTest
  EMAIL = "phb.aslan@gmail.com"
  PASSWORD = "111111"

  test "[User Registration] => Existing Email" do
    post "/api/register", params: { user: { email: EMAIL, password: PASSWORD } }
    assert_response :unprocessable_entity
    assert_equal "Email is already taken", response.parsed_body["error"]
  end

  test "[User Registration] => Success Case" do
    post "/api/register", params: { user: { email: "test1@gmail.com", password: "111111" } }
    assert_response :success
    assert_equal "User registered successfully", response.parsed_body["message"]
  end

  test "[User Login] => Success Case" do
    user = users(:one)
    post "/api/login", params: { email: EMAIL, password: PASSWORD }
    assert_response :success
  end

  test "[User Login] => Invalid Email (wrong format)" do
    user = users(:one)
    post "/api/login", params: { email: "invalid_email", password: PASSWORD }
    assert_equal "Invalid email format", response.parsed_body["error"]
  end

  test "[User Login] => Invalid Password (not enough length)" do
    user = users(:one)
    post "/api/login", params: { email: EMAIL, password: "1" }
    assert_equal "Password must be at least 6 characters long", response.parsed_body["error"]
  end
end
