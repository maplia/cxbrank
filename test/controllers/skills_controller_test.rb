require 'test_helper'

class SkillsControllerTest < ActionController::TestCase
  def setup
    @request.session[:user_id] = '00001'.to_i
  end

  test "index action" do
    get :index
    assert_response :success
    assert_template 'skills/index'
  end
end
