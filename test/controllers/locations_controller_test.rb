require "test_helper"

class LocationsControllerTest < ActionDispatch::IntegrationTest
  test "should get find" do
    get locations_find_url
    assert_response :success
  end
end
