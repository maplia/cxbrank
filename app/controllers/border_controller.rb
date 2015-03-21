class BorderController < ApplicationController
  skip_before_action :check_logined

  def index
    @page_title = 'ボーダー表'
    @music_set = Music.all_with_bonus_flag.each
  end

  def show
    number = params[:id].to_i
    musics = Music.where('number = ?', number)

    if musics.count == 0
      redirect_to :action => 'index'
    end

    @music_set = musics
    @page_title = 'ボーダー表 (' + musics.first.title + ')'
  end
end
