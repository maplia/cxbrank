require 'test_helper'

class SkillsControllerTest < ActionController::TestCase
  test "index" do
    request.session[:user_id] = '00001'.to_i
    get :index
    assert_response :success
  end

  test "edit" do
    request.session[:user_id] = '00001'.to_i
    get :edit, id: 'somedayinst'
    assert_response :success
  end

  test "confirm" do
    request.session[:user_id] = '00001'.to_i
    request.session[:skill] = {
      music_id: Music.find_by_text_id('somedayinst').id
    }
    post :confirm, ActionController::Parameters.new(
      id: 'somedayinst',
      skill: {
        comment: ''
      },
      difficulty1: {
        status: PLAY_STATUSES[:cleared][:value], rate: 100, ultimate: true
      },
      difficulty2: {
        status: PLAY_STATUSES[:cleared][:value], rate: 100, ultimate: true
      },
      difficulty3: {
        status: PLAY_STATUSES[:cleared][:value], rate: 100, ultimate: true
      },
    )
    assert_response :success
  end

  test "update" do
    request.session[:user_id] = '00001'.to_i
    request.session[:skill] = {
      music_id: Music.find_by_text_id('somedayinst').id,
      params: {
        user_id: '00001'.to_i,
        music_id: Music.find_by_text_id('somedayinst').id,
        comment: ''
      },
      difficulty1: ActionController::Parameters.new({
        status: PLAY_STATUSES[:cleared][:value], rate: 100, ultimate: true
      }).permit([
        :status, :rp, :rate, :ultimate, :grade, :combo, :locked,
      ]),
      difficulty2: ActionController::Parameters.new({
        status: PLAY_STATUSES[:cleared][:value], rate: 100, ultimate: true
      }).permit([
        :status, :rp, :rate, :ultimate, :grade, :combo, :locked,
      ]),
      difficulty3: ActionController::Parameters.new({
        status: PLAY_STATUSES[:cleared][:value], rate: 100, ultimate: true
      }).permit([
        :status, :rp, :rate, :ultimate, :grade, :combo, :locked,
      ]),
      operation: :create,
    }
    post :update, ActionController::Parameters.new(
      id: 'somedayinst', yes: 'はい'
    )
  end
end
