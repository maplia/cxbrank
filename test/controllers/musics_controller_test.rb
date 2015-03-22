require 'test_helper'

class MusicsControllerTest < ActionController::TestCase
  test "index action" do
    get :index
    assert_response :success
    assert_template 'musics/index'
  end
end
