require 'test_helper'

class VisitRecordsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get visit_records_new_url
    assert_response :success
  end

  test "should get index" do
    get visit_records_index_url
    assert_response :success
  end

  test "should get show" do
    get visit_records_show_url
    assert_response :success
  end

  test "should get edit" do
    get visit_records_edit_url
    assert_response :success
  end
end
