require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  test "index" do
    get :index
    assert_response :success
  end

  test "new" do
    get :new
    assert_response :success
  end

  test "confirm_new" do
    post :confirm_new, user: ActionController::Parameters.new(
      username: 'testuser1', password: 'testuser1', password_confirmation: 'testuser1'
    )
    assert_response :success
  end

  test "create" do
    request.session[:user] = ActionController::Parameters.new(
      username: 'testuser1', password: 'testuser1', password_confirmation: 'testuser1'
    ).permit([
      :username, :password, :password_confirmation, :cxb_id, :comment,
    ])
    post :create, ActionController::Parameters.new(yes: 'はい')
    assert_response :success

    request.session[:user] = ActionController::Parameters.new(
      username: 'testuser1', password: 'testuser1', password_confirmation: 'testuser1'
    ).permit([
      :username, :password, :password_confirmation, :cxb_id, :comment,
    ])
    post :create, ActionController::Parameters.new(no: 'いいえ')
    assert_response :redirect
  end

  test "edit" do
    request.session[:user_id] = '00001'.to_i
    get :edit
    assert_response :success
  end

  test "confirm_edit" do
    request.session[:user_id] = '00001'.to_i
    post :confirm_edit, ActionController::Parameters.new(user: {
      username: 'testuser1', password: 'testuser1', password_confirmation: 'testuser1'
    })
    assert_response :success
  end

  test "update" do
    request.session[:user] = ActionController::Parameters.new(
      username: 'testuser1'
    ).permit([
      :username, :password, :password_confirmation, :cxb_id, :comment,
    ])
    post :update, ActionController::Parameters.new(yes: 'はい')
    assert_response :redirect

    request.session[:user] = ActionController::Parameters.new(
      username: 'testuser1'
    ).permit([
      :username, :password, :password_confirmation, :cxb_id, :comment,
    ])
    post :update, ActionController::Parameters.new(no: 'いいえ')
    assert_response :redirect
  end
end
