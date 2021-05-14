require "test_helper"

class UserGroupsControllerTest < ActionDispatch::IntegrationTest
  test "should get add" do
    get user_groups_add_url
    assert_response :success
  end
end
