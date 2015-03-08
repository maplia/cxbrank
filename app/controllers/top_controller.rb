class TopController < ApplicationController
  def index
    @page_title = APP_INFO[:name]
  end
end
