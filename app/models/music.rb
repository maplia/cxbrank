class Music < ActiveRecord::Base
  attr_accessor :bonus

  def self.all_with_bonus_flag(datetime=nil)
    bonus_musics = BonusMusic.past(datetime)
    musics = self.all.order(:number)

    musics.each do |music|
      music.bonus = bonus_musics.pluck(:music_id).include?(music.id)
    end

    return musics
  end
end
