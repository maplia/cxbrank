class MusicsController < ApplicationController
  def index
    @page_title = '登録曲リスト'
    @blocks = {
      :bonus => {
        id: LIST_BLOCKS[:bonus][:id], title: LIST_BLOCKS[:bonus][:title], musics: []
      },
      :regular => {
        id: LIST_BLOCKS[:regular][:title], title: LIST_BLOCKS[:regular][:title], musics: []
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
