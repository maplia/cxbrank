class LoginController < ApplicationController
  def index
    
  end

  def auth
    user = User.authenticate(params[:userid], params[:password])
    if user
      session[:user] = user
      redirect_to '/skills'
    else
      redirect_to '/login'
    end
  end
end
