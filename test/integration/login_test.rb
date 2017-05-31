require "test_helper"

class LoginTest < ActionDispatch::IntegrationTest
  test "redirects to the login page" do
    get root_url
    assert_redirected_to new_user_session_url
  end

  test "allows authenticated users to bypass login" do
    sign_in create(:user)
    get root_url
    assert_response :ok
  end
end
