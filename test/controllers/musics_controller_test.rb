require 'test_helper'

class MusicsControllerTest < ActionController::TestCase
  test "index" do
    get :index
    assert_response :success
  end
end
