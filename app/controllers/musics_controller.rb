class MusicsController < ApplicationController
  def index
    @page_title = '登録曲リスト'
    @musics = Music.all
  end
end
