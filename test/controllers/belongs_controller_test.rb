require 'test_helper'

class BelongsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get belongs_index_url
    assert_response :success
  end

  test "should get show" do
    get belongs_show_url
    assert_response :success
  end

  test "should get edit" do
    get belongs_edit_url
    assert_response :success
  end
end
