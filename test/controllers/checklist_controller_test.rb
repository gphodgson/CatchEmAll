require 'test_helper'

class ChecklistControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get checklist_show_url
    assert_response :success
  end

  test "should get create" do
    get checklist_create_url
    assert_response :success
  end

end
