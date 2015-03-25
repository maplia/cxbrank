require 'test_helper'

class ViewControllerTest < ActionController::TestCase
  test "show" do
    get :show, id: '99999'
    assert_response :missing

    get :show, id: '00001'
    assert_response :success
  end
end
