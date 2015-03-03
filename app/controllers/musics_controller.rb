class MusicsController < ApplicationController
  def index
    @page_title = '登録曲リスト'
    @blocks = {
      :bonus => {
        id: 'bonus', title: Settings.block_title.bonus, musics: []
      },
      :regular => {
        id: 'regular', title: Settings.block_title.regular, musics: []
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
