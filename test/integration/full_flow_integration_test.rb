require "test_helper"

class FullFlowIntegrationTest < ActionDispatch::IntegrationTest
  test "Register user -> login -> access protected endpoints" do
    EMAIL = "test1@gmail.com"
    post "/api/register", params: { user: { email: EMAIL, password: "111111" } }
    assert_response :success
    assert_equal "User registered successfully", response.parsed_body["message"]

    post "/api/login", params: { email: EMAIL, password: "111111" }
    assert_response :success
    token = response.parsed_body["auth_token"]

    get "/api/videos", headers: { "Authorization" => token }
    assert_response :success

    post "/api/videos", params: { title: "test video title", url: "https://www.youtube.com/watch?v=Aa9ZnlQGw9U", description: "test" }, headers: { "Authorization" => token }
    assert_response :success

    post "/api/videos", params: { title: "test video title", url: "invalid youtube", description: "test" }, headers: { "Authorization" => token }
    assert_equal "Invalid YouTube URL", response.parsed_body["error"]
  end
end
