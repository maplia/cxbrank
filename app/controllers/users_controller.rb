class UsersController < ApplicationController
  skip_before_filter :check_logined

  def index
    @users = User.all

    @page_title = '登録ユーザーリスト'
  end

  def new
    @user = User.new
    @user.attributes = session[:user] if session[:user]

    if session[:user_errors]
      session[:user_errors].each do |error|
        @user.errors.add(error[0], error[1])
      end
      session[:user_errors] = nil
    end

    @page_title = 'ユーザー登録'
  end

  def confirm
    session[:user] = params.require(:user).permit([
      :username, :password, :password_confirmation, :cxbid, :comment,
    ])
    session[:user][:comment] = ERB::Util.html_escape(session[:user][:comment]).gsub(/&amp;/, '&')

    @user = User.new
    @user.attributes = session[:user]
    unless @user.valid?
      session[:user_errors] = @user.errors.messages
      redirect_to :new_user
    end

    @page_title = 'ユーザー登録確認'
  end

  def create
    if params[:no]
      redirect_to :new_user
    else
      @user = User.new
      @user.attributes = session[:user]

      begin
        User.transaction do
          @user.save!
          session[:user] = nil
          session[:user_errors] = nil
          session[:user_id] = @user.id
        end
      rescue
        redirect_to :new_user
      end

      @page_title = 'ユーザー登録完了'
    end
  end
end
