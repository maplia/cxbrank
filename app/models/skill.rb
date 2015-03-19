class Skill < ActiveRecord::Base
  belongs_to :user
  belongs_to :music
  has_many :skill_scores
  attr_accessor :difficulty1, :difficulty2, :difficulty3

  def self.select_by_user(user, registered_only=false, ignore_locked=false, time=nil)
    bonus_music_ids = BonusMusic.past(time).pluck(:music_id)
    skills = includes(:music).includes(:skill_scores).where('user_id = ?', user.id).to_a

    skills.each do |skill|
      skill.music.bonus = bonus_music_ids.include?(skill.music.id)
      skill.calc!(ignore_locked) if ignore_locked
    end
    unless registered_only
      musics = Music.all_with_bonus_flag(time)
      skill_hash = skills.index_by(&:music_id)

      musics.each do |music|
        unless skill_hash.has_key?(music.id)
          skills << default(user, music, true)
          skill_hash[music.id] = skills.last
        end
      end
    end
    skills.sort!

    return skills
  end

  def self.select_by_user_and_music(user, music)
    skill = includes(:music).includes(:skill_scores).where('user_id = ? and music_id = ?', user.id, music.id).first
    skill = default(user, music, true) unless skill
    skill.skill_scores.each do |score|
      difficulty_accessor_sym = "difficulty#{score.difficulty}=".to_sym
      skill.send(difficulty_accessor_sym, score)
    end

    return skill
  end

  def self.default(user, music, detail=false)
    hash = {
      user_id: user.id, music_id: music.id,
      best_difficulty: nil, best_rp: 0.00,
    }

    skill = self.new(hash)
    skill.music = music
    if detail
      skill.skill_scores = []
      DIFFICULTIES.each_key do |difficulty|
        if skill.music.level(difficulty)
          skill.skill_scores << SkillScore.default(difficulty, music.score(difficulty))
        end
      end
    end

    return skill
  end

  def calc!(ignore_locked=false)
    self.best_difficulty = 0
    self.best_rp = 0.00
    
    DIFFICULTIES.each_key do |difficulty|
      next unless music.difficulty_exist?(difficulty)

      score = skill_scores.index_by(&:difficulty)[DIFFICULTIES[difficulty][:id]]
      next if score.status != PLAY_STATUSES[:cleared][:value]

      unless score.rp
        temp_rp = self.music.level(difficulty) * (score.rate || 0) / 100.0
        if score.ultimate
          temp_rp *= 1.2
        end
        score.rp = BigDecimal.new(temp_rp.to_s).truncate(2)
      end

      if ignore_locked or !score.locked
        if best_rp < score.rp
          self.best_difficulty = DIFFICULTIES[difficulty][:id]
          self.best_rp = score.rp
        end
      end
    end
  end

  def status(difficulty)
    return send_to_score(difficulty, :status)
  end

  def locked(difficulty)
    return send_to_score(difficulty, :locked)
  end

  def ultimate(difficulty)
    return send_to_score(difficulty, :ultimate)
  end

  def rp(difficulty)
    return send_to_score(difficulty, :rp)
  end

  def rate(difficulty)
    return send_to_score(difficulty, :rate)
  end

  def grade(difficulty)
    return send_to_score(difficulty, :grade)
  end

  def combo(difficulty)
    return send_to_score(difficulty, :combo)
  end

  def ultimate_rate(difficulty)
    if ultimate(difficulty)
      rate = ((rp(difficulty) / (music.level(difficulty) * 1.2)) * 100).ceil
      return rate.to_i
    else
      return nil
    end
  end

  def <=>(other)
    if self.best_rp != other.best_rp
      return other.best_rp <=> self.best_rp
    else
      return self.music.sortkey <=> other.music.sortkey
    end
  end

  private
  def send_to_score(difficulty, symbol)
    @score_hash = skill_scores.index_by(&:difficulty) unless @score_hash
    if @score_hash.has_key?(DIFFICULTIES[difficulty][:id])
      return @score_hash[DIFFICULTIES[difficulty][:id]].send(symbol)
    else
      return nil
    end
  end
end
