require 'test_helper'

class IglockControllerTest < ActionController::TestCase
  test "show" do
    get :show, id: '00001'
    assert_response :success
  end
end
