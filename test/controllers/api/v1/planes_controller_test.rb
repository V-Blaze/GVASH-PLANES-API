require "test_helper"

class Api::V1::PlanesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get api_v1_planes_index_url
    assert_response :success
  end
end
