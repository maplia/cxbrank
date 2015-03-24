require 'test_helper'

class ViewControllerTest < ActionController::TestCase
  test "show" do
    get :show, id: '00001'
    assert_response :success
  end
end
