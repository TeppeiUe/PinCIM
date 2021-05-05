require 'test_helper'

class SalesEndsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get sales_ends_index_url
    assert_response :success
  end

  test "should get new" do
    get sales_ends_new_url
    assert_response :success
  end

  test "should get show" do
    get sales_ends_show_url
    assert_response :success
  end

  test "should get edit" do
    get sales_ends_edit_url
    assert_response :success
  end
end
