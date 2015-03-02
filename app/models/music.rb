class Music < ActiveRecord::Base
  attr_accessor :bonus

  def self.all_with_bonus_flag(datetime=nil)
    bonus_musics = BonusMusic.past(datetime)
    musics = self.all.order('number')

    musics.each do |music|
      bonus_musics.each do |bonus|
        if music.id == bonus.music_id
          music.bonus = true
          break
        end
      end
    end

    return musics
  end
end
