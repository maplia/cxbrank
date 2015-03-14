class Music < ActiveRecord::Base
  has_many :music_scores
  attr_accessor :bonus

  def self.all_with_bonus_flag(time=nil)
    bonus_music_ids = BonusMusic.past(time).pluck(:music_id)
    musics = includes(:music_scores).order(:number)

    musics.each do |music|
      music.bonus = bonus_music_ids.include?(music.id)
    end

    return musics
  end

  def difficulty_exist?(difficulty)
    return !level(difficulty).nil?
  end

  def score(difficulty)
    @score_hash = music_scores.index_by(&:difficulty) unless @score_hash
    return @score_hash[DIFFICULTIES[difficulty][:id]]
  end

  def level(difficulty)
    return send_to_score(difficulty, :level)
  end

  def notes(difficulty)
    return send_to_score(difficulty, :notes)
  end

  private
  def send_to_score(difficulty, symbol)
    @score_hash = music_scores.index_by(&:difficulty) unless @score_hash
    if @score_hash.has_key?(DIFFICULTIES[difficulty][:id])
      return @score_hash[DIFFICULTIES[difficulty][:id]].send(symbol)
    else
      return nil
    end
  end
end
