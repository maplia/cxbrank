class Music < ActiveRecord::Base
  has_one :skill
  attr_accessor :bonus

  def self.all_with_bonus_flag(time=nil)
    bonus_musics = BonusMusic.past(time)
    musics = self.all.order(:number)

    musics.each do |music|
      music.bonus = bonus_musics.pluck(:music_id).include?(music.id)
    end

    return musics
  end

  def level(difficulty)
    return self["#{difficulty}_level".to_sym]
  end

  def notes(difficulty)
    return self["#{difficulty}_notes".to_sym]
  end
end
