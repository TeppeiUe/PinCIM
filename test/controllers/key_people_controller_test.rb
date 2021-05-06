require 'test_helper'

class KeyPeopleControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get key_people_index_url
    assert_response :success
  end

  test "should get show" do
    get key_people_show_url
    assert_response :success
  end

  test "should get edit" do
    get key_people_edit_url
    assert_response :success
  end
end
