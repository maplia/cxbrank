class Music < ActiveRecord::Base
  has_many :music_scores
  attr_accessor :bonus
  attr_accessor :difficulty1, :difficulty2, :difficulty3, :difficulty4, :difficulty5

  def self.all_with_bonus_flag(time=nil)
    bonus_musics = BonusMusic.past(time)
    musics = self.includes(:music_scores).order(:number)

    musics.each do |music|
      music.bonus = bonus_musics.pluck(:music_id).include?(music.id)
      music.music_scores.each do |score|
        case score.difficulty
        when DIFFICULTIES[:difficulty1][:id]; music.difficulty1 = score
        when DIFFICULTIES[:difficulty2][:id]; music.difficulty2 = score
        when DIFFICULTIES[:difficulty3][:id]; music.difficulty3 = score
        when DIFFICULTIES[:difficulty4][:id]; music.difficulty4 = score
        when DIFFICULTIES[:difficulty5][:id]; music.difficulty5 = score
        end
      end
    end

    return musics
  end

  def level(difficulty)
    return send(difficulty).level
  end

  def notes(difficulty)
    return send(difficulty).notes
  end
end
