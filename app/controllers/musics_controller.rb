class MusicsController < ApplicationController
  def index
    @page_title = '登録曲リスト'
    @blocks = [
      {
        :id => 'bonus', :title => '期間限定RP対象曲', :musics => Music.bonus_musics
      },
      {
        :id => 'regular', :title => '一般曲', :musics => Music.regular_musics
      },
    ]
  end
end
