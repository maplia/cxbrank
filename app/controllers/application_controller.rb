class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :check_logined
  rescue_from Cxbrank::UserNotFoundError, with: :report_user_not_found

  private
  def check_logined
    unless session[:user_id]
      flash[:referer] = request.fullpath
      redirect_to :login
    end
  end

  def report_user_not_found
    @page_title = 'エラー'
    @skip_address = true

    render 'error/user_not_found_error', status: 404
  end
end
