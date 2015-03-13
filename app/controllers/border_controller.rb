class BorderController < ApplicationController
  def index
    @page_title = 'ボーダー表'
    @blocks = {
        :regular => {
            id: LIST_BLOCKS[:regular][:title], title: LIST_BLOCKS[:regular][:title], musics: []
        },
    }

    Music.all_with_bonus_flag.each do |music|
      @blocks[:regular][:musics] << music
    end
  end
end
