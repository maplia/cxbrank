class LoginController < ApplicationController
  skip_before_filter :check_logined

  def index
  end

  def auth
    user = User.authenticate(params[:userid], params[:password])
    if user
      session[:user_id] = user.id.to_i
      redirect_to '/skills'
    else
      redirect_to '/login'
    end
  end
end
