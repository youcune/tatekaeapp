require 'test_helper'

class AdminControllerTest < ActionController::TestCase
  test "should get events_index" do
    get :events_index
    assert_response :success
  end

end
