class MusicsController < ApplicationController
  skip_before_action :check_logined

  def index
    @music_set = MusicSet.all

    @page_title = '登録曲リスト'
  end
end
