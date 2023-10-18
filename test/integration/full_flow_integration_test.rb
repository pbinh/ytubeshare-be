require "test_helper"

class FullFlowIntegrationTest < ActionDispatch::IntegrationTest
  test "Register user -> login -> access protected endpoints" do
    post "/api/register", params: { user: { email: "phb.aslan@gmail.com", password: "111111" } }
    assert_response :success
    assert_equal "User registered successfully", response.parsed_body["message"]

    post "/api/login", params: { email: "phb.aslan@gmail.com", password: "bcb15f821479b4d5772bd0ca866c00ad5f926e3580720659cc80d39c9d09802a" }
    assert_response :success
    token = response.parsed_body["auth_token"]

    get "/api/videos", headers: { "Authorization" => token }
    assert_response :success

    post "/api/videos", params: { video: { title: "test video title", url: "https://www.youtube.com/watch?v=Aa9ZnlQGw9U", description: "test", metadata: "" } }, headers: { "Authorization" => token }
    assert_response :success
  end
end
