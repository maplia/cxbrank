class UsersController < ApplicationController
  skip_before_action :check_logined, only: [:index, :new, :confirm_new, :create]
  include ParamUtil

  def index
    @users = User.all

    @page_title = '登録ユーザーリスト'
  end

  def new
    @user = User.new(session[:user])
    @user.add_error_messages(session[:user_error_messages])
    session[:user_error_messages] = nil

    @page_title = 'ユーザー登録'
  end

  def confirm_new
    session[:user] = params.require(:user).permit([
      :username, :password, :password_confirmation, :cxb_id, :comment,
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
          session[:user_id] = @user.id.to_i
        end
      rescue
        redirect_to :new_user
      end

      @page_title = 'ユーザー登録完了'
    end
  end

  def edit
    @user = User.current(session)
    @user.add_error_messages(session[:user_error_messages])
    session[:user_error_messages] = nil

    @page_title = 'ユーザー情報編集'
  end

  def confirm_edit
    session[:user] = params.require(:user).permit([
      :username, :password, :password_confirmation, :cxb_id, :comment,
    ])

    @user = User.current(session)
    @user.attributes = session[:user].delete_blank
    unless @user.valid?
      session[:user_error_messages] = @user.errors.messages
      redirect_to :edit_user
    end

    @page_title = 'ユーザー情報編集確認'
  end

  def update
    if params[:no]
      redirect_to :edit_user
    else
      user = User.current(session)
      user.update(session[:user].delete_blank)
      begin
        User.transaction do
          user.save!
          session[:user] = nil
        end
        redirect_to :skills
      rescue
        redirect_to :edit_user
      end
    end
  end
end
