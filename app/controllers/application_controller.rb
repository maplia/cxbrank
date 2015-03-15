class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :check_logined
  before_action :set_request_variant
  rescue_from Cxbrank::UserNotFoundError, with: :report_user_not_found

  private
  def check_logined
    unless session[:user_id]
      flash[:referer] = request.fullpath
      redirect_to :login
    end
  end

  # http://k0kubun.hatenablog.com/entry/2014/11/21/041949
  def set_request_variant
    request.variant = request.device_type
  end

  def report_user_not_found
    @page_title = 'エラー'
    @skip_address = true

    render 'error/user_not_found_error', status: 404
  end
end
