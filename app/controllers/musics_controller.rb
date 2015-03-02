class MusicsController < ApplicationController
  def index
    @page_title = '登録曲リスト'
    @blocks = {
      :bonus => {
        :id => 'bonus', :title => '期間限定RP対象曲', :musics => []
      },
      :regular => {
        :id => 'bonus', :title => '一般曲', :musics => []
      },
    }

    Music.all_with_bonus_flag.each do |music|
      if music.bonus
        @blocks[:bonus][:musics] << music
      else
        @blocks[:regular][:musics] << music
      end
    end
  end
end
