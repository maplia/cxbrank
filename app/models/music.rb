class Music < ActiveRecord::Base
  has_many :music_scores, -> {order(:difficulty)}
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
    return self.music_scores.where("difficulty = ?", difficulty).first.level
  end

  def notes(difficulty)
    return self.music_scores.where("difficulty = ?", difficulty).first.notes
  end
end
