require 'test_helper'

class YatchsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get yatchs_index_url
    assert_response :success
  end

  test "should get show" do
    get yatchs_show_url
    assert_response :success
  end

  test "should get book" do
    get yatchs_book_url
    assert_response :success
  end

  test "should get review" do
    get yatchs_review_url
    assert_response :success
  end

  test "should get create" do
    get yatchs_create_url
    assert_response :success
  end

  test "should get edit" do
    get yatchs_edit_url
    assert_response :success
  end

  test "should get destroy" do
    get yatchs_destroy_url
    assert_response :success
  end

end
