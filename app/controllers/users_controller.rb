class UsersController < ApplicationController
  skip_before_action :check_logined
  include ParamUtil

  def index
    @users = User.all

    @page_title = '登録ユーザーリスト'
  end

  def new
    @user = User.new(session[:user])
    @user.add_errors(session[:user_error_messages])
    session[:user_error_messages] = nil

    @page_title = 'ユーザー登録'
  end

  def confirm_new
    session[:user] = params.require(:user).permit([
      :username, :password, :password_confirmation, :cxbid, :comment,
    ])

    @user = User.new(session[:user])
    unless @user.valid?
      session[:user_error_messages] = @user.errors.messages
      redirect_to :new_user
    end

    @page_title = 'ユーザー登録確認'
  end

  def create
    if params[:no]
      redirect_to :new_user
    else
      begin
        User.transaction do
          @user = User.create!(session[:user].delete_blank)
          session[:user] = nil
          session[:user_id] = @user.id
        end
      rescue
        redirect_to :new_user
      end

      @page_title = 'ユーザー登録完了'
    end
  end
end
