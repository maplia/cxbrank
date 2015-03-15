class BorderController < ApplicationController
  skip_before_filter :check_logined

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
