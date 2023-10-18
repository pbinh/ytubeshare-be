require "test_helper"

class ProtectedApisTest < ActionDispatch::IntegrationTest
  test "get list of videos" do
    get "/api/videos"
    assert_response :unauthorized
  end

  test "add a video to user" do
    post "/api/videos", params: { video: { title: "test video title", url: "https://www.youtube.com/watch?v=Aa9ZnlQGw9U", description: "test", metadata: "" } }
    assert_response :unauthorized
  end
end
