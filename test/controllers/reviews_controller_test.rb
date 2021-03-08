require 'test_helper'

class ReviewsControllerTest < ActionDispatch::IntegrationTest
  test "should get update" do
    get reviews_update_url
    assert_response :success
  end

end
