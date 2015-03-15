class TopController < ApplicationController
  skip_before_filter :check_logined

  def index
    @page_title = APP_INFO[:name]
  end
end
